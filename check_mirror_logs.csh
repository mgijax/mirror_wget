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
    grep -i 'Failure' $file
    grep -i 'Fatal' $file
    grep -i 'Failed' $file
    grep -i 'timed out' $file
    grep -i 'Cannot' $file
    grep -i 'error' $file
    grep -i 'Error' $file
    grep -i 'exists' $file
    grep -i 'file shrunk' $file
end
echo "Finished grepping for errors"

