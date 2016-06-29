#!/bin/sh 

#
# Wrapper for mirroring weekly files that need to be logged in RADAR.
# Usage:  weeklycron-logged.sh
#
# History
#
# 04/05/2016 lnh
#    TR12266 : Migrate mirror_ftp to mirror_wget

cd `dirname $0` 
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

FILES="ftp.ncbi.nih.gov.gbNC 
ftp.ncbi.nih.gov.gbTpaNC 
ftp.ncbi.nih.gov.refseqDaily 
ftp.ncbi.nih.gov.gbDel"

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

#if [ $? -gt 0 ]
#then
#   echo "Mirror failed"
#   exit 1
#fi
# now log the GenBank/RefSeq files in RADAR
${RADAR_DBUTILS}/bin/logFileToProcessByDir.csh ${RADAR_DBSCHEMADIR} ${DATADOWNLOADS}/genbank_daily ${DATADOWNLOADS}/genbank_daily GenBank_preprocess
${RADAR_DBUTILS}/bin/logFileToProcessByDir.csh ${RADAR_DBSCHEMADIR} ${DATADOWNLOADS}/ftp.ncbi.nih.gov/refseq/daily ${DATADOWNLOADS}/ftp.ncbi.nih.gov/refseq/daily RefSeq_preprocess
${RADAR_DBUTILS}/bin/logFileToProcessByDir.csh ${RADAR_DBSCHEMADIR} ${DATADOWNLOADS}/grendel.jax.org/TPA/non-cumulative ${DATADOWNLOADS}/grendel.jax.org/TPA/non-cumulative GenBank_preprocess

date 
