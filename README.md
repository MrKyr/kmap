## gmap.sh 1.0 (28 March 2016)
(c) Kyriakos Bellios (kyr@designisdesign.eu)

## Licence
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

## About
This is a simple script to create free maps for Garmin. Preview the map in [Qmapshack](https://bitbucket.org/maproom/qmapshack/wiki/Home)

## Dependencies
- [gdal](http://www.gdal.org): Geospatial Data Abstraction Library
- [mkgmap & splitter](http://www.mkgmap.org.uk): Making maps from OpenStreetMap for Garmin devices

#### Optional:
- [routino](http://www.routino.org/download/): Router for OpenStreetMap Data
 
  - *open QmapShack application*
 
            Tool -> Create Routino Database 
                 -> Select source files (the .pbf) 
                 -> Target Path (the folder ex. ROUTES) 
                 -> File Prefix (Country ex. GR)
                 -> Start

## Instalation
Nothing special here

## Prepare
### Get the data
* **Country Map**  
  <http://download.geofabrik.de/europe.html>
  
  **Place it in:**
  > gmaps parent folder
  >> data
  >>> maps
  
* **Sea & Boundaries**  
  <http://develop.freizeitkarte-osm.de/boundaries/>
  
  **Place it in:**
  > gmaps parent folder
  >> data

* **Elevation Data (DEM)**  
  <http://www.viewfinderpanoramas.org/Coverage%20map%20viewfinderpanoramas_org3.htm>  
  **or**  
  <http://srtm.csi.cgiar.org/SELECTION/inputCoord.asp>  
  * *Select tiles on map to begin download then extract the .zip file & open QmapShack application*  
    
            Tool -> VRT Builder -> 
                 -> Select source files (all *.hgt)*
                 -> Target Path (the folder ex. DEM) 
                 -> Start
     
  * *if there is more than one .zip file create a folder & etxract all .hgt there.*

* **Contours**
  
  * Download ready contours (20 | 100 | 500) from: <http://develop.freizeitkarte-osm.de>  
    **or**
  * Extract from: <http://extract.bbbike.org>

  **Place it in:**
  > gmaps-'version'
  >> data
  >>> contours
  
## Usage
    gmap.sh [COUNTRY NAME] [OPTIONS]
    
   **Important:** You must specify the Country name first
   
   **examples:**
     
   * Split big .pbf map

        gmap.sh -s ../data/greece-latest.osm.pbf

* Maps
 * Clean, split, build, create & move the map
   
              gmap.sh -c Greece -x -s ../data/greece-latest.osm.pbf -bmg   
              
 * Build, create & move the map
 
              gmap.sh -c Greece -bmg
              
 * Create (apply custom type) & move the map

              gmap.sh -c Greece -mg
              
* Contours
 * Clean, split, build, create & move the contours map

             gmap.sh -c Greece -x -s ../data/Greece-Contours.osm.obf -kng
             
 * Build, create & move the map

             gmap.sh -c Greece -kng
             
 * Create (apply custom type) & move the map

             gmap.sh -c Greece -ng
                
## Options
**Note:** `-c` & `-s` needs an argument  

* `-c` country name (**user input**) **MUST BE FIRST**
* `-s` split the big map (**user input**)
* `-b` build map with custom styles
* `-m` create garmin map with custom type (.typ)
* `-k` build elevation contours
* `-n` create garmin contours map with custom type (.typ)
* `-g` move the final map/contours to Qmapshack maps location
* `-x` clean directory (delete *.img)
* `-h` help screen

## Bugs
Please report any bug you found at <kyr@designisdesign.eu>

## Changelog
gmap.sh 1.0 (28 March 2016)
  
* Initial release

## To-Do
* More check's for correct user input 
