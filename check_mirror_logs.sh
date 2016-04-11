#!/bin/sh

#
# This script checks logs generated
# from wget process for errors
# It is called by scripts that run daily and weekly mirrors
# (dailycron.csh, dailycron2.sh, ...)
#
# Usage: ./check_mirror_log.sh report_out_file list_of_log_files
# Example: 
# ./check_mirror_log.sh $MIRRORLOGS/dailycron2.sh.log $MIRRORLOGS/ftp.geneontology.org.external2go.log $MIRRORLOGS/ftp.geneontology.org.gene-associations.log  
#
# Author: lnh
# Date : 04/05/2016
#

log_report=""
LOG_FILES=""

if [ $# -lt 2 ]
then
   echo "Usage: ./check_mirror_log.sh report_out_file list_of_log_files "
   exit 1
fi

log_report=$1
LOG_FILES=$2

ERROR_TERMS=("ERROR" 
"Fatal"
"Failure"
"failed"
"ERROR 404: Not Found"
"timed out"
"No such file or directory")

IFS=""
#'No such file or directory'"
function getLogStatus() {
  log=$1
  rstatus="Success"
  for ((i = 0; i < ${#ERROR_TERMS[@]}; i++))
  do
       error_term=${ERROR_TERMS[$i]}
       error_found=`grep -i $error_term $log `
       if [ "$error_found" != "" ]
       then
            rstatus="Failed"
            echo "Found: \"$error_found\" "
            
        fi
  done
  echo "Status: $rstatus" 
}

rm -rf $log_report
touch $log_report
date | tee -a $log_report
run_status=""
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
   echo "**************************************"| tee -a $log_report
   getLogStatus $log | tee -a $log_report
   echo "--------------------------------------- " | tee -a $log_report
done
echo "Logs check done " | tee -a $log_report
date | tee -a $log_report
mailx -s "MIRROR: $log_report" mgiadmin < $log_report

