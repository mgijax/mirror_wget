#!/bin/csh -x -f

#
# Wrapper for running weekly crons
#
# Usage:  weeklycron.csh
#
# History
#
# 07/06/2010	lec
#	- TR 9316/cgd.jax.org
#	  if you need to add this to weekly tasks,
#         then it is the same as mouse.brain-map.org
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
func.med.harvard.edu \
www.genenames.org \
www.i-dcc.org1 \
www.i-dcc.org2 \
www.i-dcc.org3 \
www.sanger.ac.uk5 \
)
$i
end

date
