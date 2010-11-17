#!/bin/csh -x -f

#
# Wrapper for running daily crons
#
# Usage:  dailycron.csh
#
# History
#
# 11/13/2003	lec
#	- TR 5310; new
#

cd `dirname $0` && source ./Configuration

date

foreach i (\
www.ncbi.nlm.nih.gov \
www.genetrap.org \
www.sanger.ac.uk \
www.sequenceontology.org \
)
set URL=`cut -f1 $i`
set LOG=`cut -f2 $i`
runwget.csh ${URL} ${LOG}
end

foreach i (\
www.sanger.ac.uk2 \
www.sanger.ac.uk3 \
www.sanger.ac.uk4 \
www.norcomm.org \
)
$i
end

date
