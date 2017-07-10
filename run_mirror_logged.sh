#!/bin/sh 
#
#  run_mirror_logged.sh
###########################################################################
#
#  Purpose:  This script will call the mirror wrapper script to download
#            a list of files that need to be logged in the radar database.
#
#  Usage:
#
#      run_mirror_logged.sh
#
#  Env Vars:  None
#
#  Inputs:  None
#
#  Outputs:  None
#
#  Exit Codes:
#
#      0:  Successful completion
#      1:  Fatal error occurred
#
#  Assumes:  Nothing
#
#  Implementation:  See inline comments.
#
#  Notes:  None
#
###########################################################################

cd `dirname $0`
. ./Configuration

PACKAGE_LIST=packagelist.weekly.logged

#
# Make sure the package list exists.
#
if [ ! -f ${PACKAGE_LIST} ]
then
    echo "Package list does not exist: ${PACKAGE_LIST}"
    exit 1
fi

#
# Call the mirror wrapper script for the package list.
#
./run_mirror.sh ${PACKAGE_LIST}

#
# Log the files in the radar database.
#
${RADAR_DBUTILS}/bin/logFileToProcessByDir.csh ${RADAR_DBSCHEMADIR} ${DATADOWNLOADS}/genbank_daily ${DATADOWNLOADS}/genbank_daily GenBank_preprocess
${RADAR_DBUTILS}/bin/logFileToProcessByDir.csh ${RADAR_DBSCHEMADIR} ${DATADOWNLOADS}/ftp.ncbi.nih.gov/refseq/daily ${DATADOWNLOADS}/ftp.ncbi.nih.gov/refseq/daily RefSeq_preprocess
${RADAR_DBUTILS}/bin/logFileToProcessByDir.csh ${RADAR_DBSCHEMADIR} ${DATADOWNLOADS}/grendel.jax.org/TPA/non-cumulative ${DATADOWNLOADS}/grendel.jax.org/TPA/non-cumulative GenBank_preprocess

exit 0
