#!/bin/bash


#Watch and destination variables.  Change accordingly.

MAINWATCH=WATCH
SUBWATCHDIR=DROP-FOLDER
DESDIR=ARCHIVED

#date variable.  Used to append archive date to log and tar file.

suffix=$(date +%m-%d-%Y)

#cd to watch folder
cd /${MAINWATCH}/${SUBWATCHDIR}/

#loop across subdirectories within watch folder.  

for DIR in $(ls | grep [a-z.]*$)
do
  echo "Analysing directory:" $DIR
  cpath=/${DESDIR}/${DIR}
  
  #Check to see if destination directory exists.
  if  [ -d $cpath ];
  then
    filler="umin"
  else
    #Creating destination directory if it doesn't exist.  
    echo "Creating directory for archive..." $cpath
    mkdir -p $cpath
    echo "Done."
   
  fi
  echo "Generating log of directory contents..."
  #Generate a list of directory contents with size of each file.
  du -ahc ${DIR} >> /${DESDIR}/${DIR}/${DIR}-$suffix-contents.log
  echo "Done!"
  echo "Compressing directory..."
  #Compress it to tar in destination directory
  tar -zvcf /${DESDIR}/${DIR}/${DIR}-$suffix.tar.gz ./$DIR
  echo "...done!"

done
