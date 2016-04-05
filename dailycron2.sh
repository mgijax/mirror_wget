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
# Source mgiconfig master config file
MGICONFIG=/usr/local/mgi/live/mgiconfig
if [ ! -f $MGICONFIG/master.config.sh ]
then
  echo "$MGICONFIG/master.config.sh main Configuration file is missing"
  exit 1
fi
. $MGICONFIG/master.config.sh
SCRIPT_NAME=`basename $0`
MIRRORLOG=${DATADOWNLOADS}/mirror_wget_logs

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
log_report=$MIRRORLOG/$SCRIPT_NAME.log
function getLogStatus() {
  log=$1
  fail=0
  for error_term in `echo "ERROR error Fatal Failure Cannot failed 'timed out' 'No such'"`
  do
       error_found=`cat $log | grep "$error_term"`
       if [ "$error_found" != "" ]
       then
            let "fail+=1"
            echo "$error_found "
        fi
  done
  return $fail
}

rm -rf $log_report
touch $log_report
date | tee -a $log_report
for log in $LOG_FILES
do
  if [ ! -f $log ]
  then 
       echo "--------------------------------------- " | tee -a $log_report
       echo "Sanity Check on : $log " | tee -a $log_report
       echo "ERROR: $log does not exist " | tee -a $log_report
       echo "Status: Failed " | tee -a $log_report
       continue
   fi
   echo "--------------------------------------- " | tee -a $log_report
   echo "Sanity Check on : $log " | tee -a $log_report
   getLogStatus $log
   if [ $? -gt 0 ]
   then
       echo "ERROR: $log contains errors" | tee -a $log_report
       echo "Status: Failed " | tee -a $log_report
   else
       echo "Clean: $log" | tee -a $log_report
       echo "Status: Success " | tee -a $log_report
   fi 
   echo "--------------------------------------- " | tee -a $log_report
done
echo "Logs check done " | tee -a $log_report
mailx -s "MIRROR: $log_report" mgiadmin < $log_report
date | tee -a $log_report
