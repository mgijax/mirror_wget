#!/bin/csh -x -f

#
# Wrapper for running weekly crons
#
# Usage:  weeklycron.csh
#
# History
#
# 01/29/2007	lec
#	- TR 8123
#

cd `dirname $0` && source ./Configuration

date

foreach i (\
mouse.brain-map.org \
)
set URL=`cut -f1 $i`
set LOG=`cut -f2 $i`
runwget.csh ${URL} ${LOG}
end

foreach i (\
www.genenames.org \
)
$i
end

date
