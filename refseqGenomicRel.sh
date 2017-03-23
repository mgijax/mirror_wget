#!/bin/sh 
#
# This is the main script to run Refseq Genomic release mirror 
#    (on demand when  there is a new genome build)
#
# Usage:  refseqGenomicRel.sh
# 
# Author: sc
# Date: 03/20/2017
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

package="ftp.ncbi.nih.gov.refseqGenomicRel"

LOG_FILES="$MIRRORLOG/$package.log"
echo "Downloading  $package"
./download_package $package

if [ $? -ne 0 ]
then
   echo "./download_package $package failed"
   exit 1
fi

# Check logs for errors
echo "Starting sanity check on $LOG_FILES"
log_report="$MIRRORLOG/$SCRIPT_NAME.check_mirror_logs.sh.log"
./check_mirror_logs.sh $log_report "$LOG_FILES"

date 

exit 0
