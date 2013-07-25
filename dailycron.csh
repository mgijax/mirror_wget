#!/bin/csh -fx

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
www.genetrap.org \
www.sequenceontology.org \
purl.obolibrary.org \
purl.obolibrary1.org \
purl.obolibrary2.org \
purl.obolibrary3.org \
purl.obolibrary4.org \
purl.obolibrary5.org \
)
set URL=`cut -f1 $i`
set LOG=`cut -f2 $i`
runwget.csh ${URL} ${LOG}
end

foreach i (\
www.sanger.ac.uk2 \
www.sanger.ac.uk3 \
www.sanger.ac.uk4 \
www.gensat.org \
)
$i
end

date
