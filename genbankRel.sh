#!/bin/sh 
#
# This is the main script to run GenBank release mirror (28th of the month @ 9:00 PM).
#
# Usage:  genbankRel.sh
# 
# Author: lnh
# Date: July 1, 2016
#
# Assumes: 
# 1) ftp.ncbi.nih.gov.gbRel config file has been updated
#        with current data path on remote and local servers.
# 2) ftp.ncbi.nih.gov.gbRel config file in the same directory as this main script
#
#

# Source mgiconfig master config file
cd `dirname $0`
WORKING_DIR=`pwd`
SCRIPT_NAME=`basename $0`
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

package="ftp.ncbi.nih.gov.gbRel"

LOG_FILES="$MIRRORLOG/$package.log"
echo "Downloading  $package"
./download_package $package

if [ $? -ne 0]
   echo "./download_package $package failed"
   exit 1
if
#Check logs for errors
echo "Starting sanity check on $LOG_FILES"
log_report="$MIRRORLOG/$SCRIPT_NAME.check_mirror_logs.sh.log"
./check_mirror_logs.sh $log_report "$LOG_FILES"

date 

exit 0