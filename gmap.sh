#!/bin/bash
# Variables
SEA=../data/sea.zip
BOUNDS=../data/bounds.zip
STYLE=../styles/kyr/map
C_STYLE=../styles/kyr/contours
TYPE=../types/kyr/map.typ
C_TYPE=../types/kyr/contours.typ 
QMAPSHACK=../maps
# Apps
MKGMAP=../apps/mkgmap-r3671/mkgmap.jar
SPLITTER=../apps/splitter-r435/splitter.jar
 
set -e

# Help screen
function usage ()
{
   cat <<END
$0 (Build Garmin Maps) 0.1-beta ( ) Copyleft 2016 Kyriakos Bellios <kyr_AT_designisdesign_DOT_eu>

Usage: $0 <options>
  -c Country name (User input) **MUST BE FIRST**

  -s split the big map

  -b build map with custom styles
  -m create garmin map with custom type (.typ)

  -k build elevation contours
  -n create garmin contours map with custom type (.typ)

  -g move the final map/contours to Qmapshack maps location

  -x clean directory (delete *.img)

  -h This Help Screen

Example: <Split big .pbf map>
  ex. $0 -s ../maps/greece-latest.osm.pbf

Examples: <Maps>
  ex.1 Clean, split, build, create & move the map
    $0 -c Greece -x -s ../maps/greece-latest.osm.pbf -bmg

  ex.2 Build, create & move the map
    $0 -c Greece -bmg
   
  ex.3 Create (apply custom type) & move the map
    $0 -c Greece -mg

Examples: <Contours>
  ex.1 Clean, split, build, create & move the contours map
    $0 -c Greece -x -s ../maps/greece-contours.osm.pbf -kng

  ex.2 Build, create & move the map
    $0 -c Greece -kng
   
  ex.3 Create (apply custom type) & move the map
    $0 -c Greece -ng

END
}

function _clean()
{
echo "Cleaning..."
sleep 3
echo rm -f *.img
echo
echo "Cleaning Done!"
}

function _split()
{
echo "Start splitting......"
sleep 3 
java -Xmx1024m -jar "$SPLITTER" --max-nodes=900000 "$OPTARG" 
echo
echo "Splitting Done!"
}

function _build()
{
echo "Start building......"
sleep 3 
java -Xmx1024m -jar "$MKGMAP" \
    --ignore-osm-bounds \
    --precomp-sea="$SEA" \
    --bounds="$BOUNDS" \
    --style-file="$STYLE" \
    --remove-short-arcs --family-name="$COUNTRY" \
    --mapname=63240001 --code-page=1253 \
    --lower-case --net --route --road-name-pois \
    -c template.args
echo
echo "Building $COUNTRY Done!"
}

function _contours()
{
COUNTRY="$COUNTRY"_Contours
echo "Start contours building......"
sleep 3 
java -Xmx1024m -jar "$MKGMAP" \
    --max-jobs=2 --keep-going \
    --reduce-point-density=0 --transparent \
    --description=Contours --area-name="$COUNTRY"__Contours \
    --style-file="$C_STYLE" \
    -c template.args
echo
echo "Building $COUNTRY contours Done!"
}

function _map()
{
echo "Create & apply .typ map"
sleep 3
java -Xmx1024m -jar "$MKGMAP" "$TYPE" --gmapsupp 63240*.img
echo
echo "Ready!"
}

function _cmap()
{
echo "Create & apply .typ contours map"
sleep 3
java -Xmx1024m -jar "$MKGMAP" "$C_TYPE" --gmapsupp 63240*.img
echo
echo "Ready!"
}

function _move()
{
echo "Moving $COUNTRY Map"
sleep 3
mv gmapsupp.img "$QMAPSHACK"/"$COUNTRY".img
echo
echo "Moving $COUNTRY Done!"
}

# Triggers
while getopts "hs:bmkngxc:" OPT; do
    case "$OPT" in
    h)
        usage;
        ;;
    s)
        _split;
        ;;
    b)
        _build;
        ;;
    m)
        _map;
        ;;
    k)
        _contours;
        ;;
    n)
        _cmap;
        ;;
    g)
        _move;
        ;;
    x)
        _clean;
        ;;
    c)
        COUNTRY=$OPTARG;
        ;;
    ?)
        exit 1
    esac
done

# Check for user input
if [ -z "$1" ]; then
    usage >&2
    exit 1
fi

set -u
