#!/bin/sh 
#
#  run_mirror.sh
###########################################################################
#
#  Purpose:  This script will mirror files that are defined in the package
#            list that is provided as an argument.
#
#  Usage:
#
#      run_mirror.sh  package_list
#
#      where
#
#          package_list is a file that contains the list of packages
#                       to be downloaded
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

#
# Make sure an argument was passed to the script.
#
if [ $# -ne 1 ]
then
    echo "Usage: $0 package_list"
    exit 1
fi

PACKAGE_LIST=$1

#
# Make sure the package list exists.
#
if [ ! -f ${PACKAGE_LIST} ]
then
    echo "Package list does not exist: ${PACKAGE_LIST}"
    exit 1
fi

#
# Run the download script for each package file in the package list.
#
for i in `cat ${PACKAGE_LIST} | grep -v "^#"`
do 
    echo "Downloading $i"
    ./download_package $i
done

exit 0
