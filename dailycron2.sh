#!/bin/sh 

#
# This script runs daily to download GO files.
# GO packages:
#  1) ftp.geneontology.org.external2go 
#  2) ftp.geneontology.org.gene-associations 
#  3) ftp.geneontology.org.gene-associations.paint
#
# Usage:  dailycron2.sh
#
# History
#
# 04/05/2016 lnh
#    TR12266 : Migrate mirror_ftp to mirror_wget
#
# 12/20/2004	lec
#	- moved GO FTP to this file because it has to run at 1:30AM or late
#	- the GO files are not refreshed until 1AM EDT.
#

cd `dirname $0` 
#
SCRIPT_NAME=`basename $0`
WORKING_DIR=`pwd`
#
# Check if the main config file exists
#
MAIN_CONFIG=$WORKING_DIR/Configuration

if [ ! -r $MAIN_CONFIG ]
then
  echo "The main Configuration file is missing from $WORKING_DIR"
  echo "Run the Install script "
  exit 1
fi
# source the main config file
. ${MAIN_CONFIG}

date

FILES="ftp.geneontology.org.external2go 
ftp.geneontology.org.gene-associations 
ftp.geneontology.org.gene-associations.paint"

LOG_FILES=""
for package in $FILES
do 
    echo "Downloading  $package"
    LOG_FILES="$LOG_FILES $MIRRORLOG/$package.log"
    ./download_package $package
done

#Check logs for errors
echo "Running sanity check on $LOG_FILES"
log_report="$MIRRORLOG/$SCRIPT_NAME.check_mirror_logs.sh.log"
./check_mirror_logs.sh $log_report "$LOG_FILES"
date 

