#!/bin/csh -f

#
#  check_mirror_logs.csh
###########################################################################
#
#  Purpose: Greps thru all mirror logs to determine errors that mirror
#           itself does not consider errors 
#
#  Usage:
#
#      check_mirror_logs.csh
#
#  Env Vars:
#
#      See the configuration file
#
#  Inputs:
#
#     - Configuration file
#     - all *.log files in $MIRRORLOG
#  Outputs:
#
#      - output of grep commands to stdout (will appear in cron mail)
#
#  Exit Codes:
#
#      0:  Successful completion
#      1:  Fatal error occurred
#
#  Assumes:  Nothing
#
#  Implementation:
#
#  Notes:  None
#
###########################################################################

cd `dirname $0` && source ./Configuration

echo "Grepping the mirror logs for errors:"
foreach file ( `ls ${MIRRORLOG}/*.log` )
    echo "checking $file"
    grep 'Failure' $file
    grep 'Fatal' $file
    grep 'Failed' $file
    grep 'timed out' $file
    grep 'Cannot' $file
    grep 'error' $file
    grep 'Error' $file
    grep 'exists' $file
    grep 'file shrunk' $file
end
echo "Finished grepping for errors"

