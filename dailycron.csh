#!/bin/csh -f

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
purl.obolibrary1.org \
purl.obolibrary2.org \
purl.obolibrary3.org \
purl.obolibrary4.org \
purl.obolibrary5.org \
build.berkeleybop.org \
)
set URL=`cut -f1 $i`
set LOG=`cut -f2 $i`
echo $i
runwget.csh ${URL} ${LOG}
end

# standalone scripts
foreach i (\
purl.obolibrary.org \
www.gensat.org \
ftp.ebi.ac.uk_goa \
ftp.ebi.ac.uk_interpro \
ftp.ebi.ac.uk_arrayexpress \
)
echo $i
$i
end

date
