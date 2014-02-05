#!/bin/csh -f

#
# Wrapper for running weekly crons
#
# Usage:  weeklycron.csh
#
# History
#
# 02/05/2014
#	- TR11515/add www.mousephenotype.org
#
# 07/22/2013
#	- TR11442/remove www.europhenome.org temporarily
#
# 10/31/2012
#	- TR10273/added www.sanger.ac.uk5; www.europhenome.org
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
func.med.harvard.edu \
)
set URL=`cut -f1 $i`
set LOG=`cut -f2 $i`
echo $i
runwget.csh ${URL} ${LOG}
end

#remove temporarily
#www.europhenome.org \
foreach i (\
www.genenames.org \
www.i-dcc.org1 \
www.i-dcc.org2 \
www.i-dcc.org3 \
www.sanger.ac.uk5 \
www.mousephenotype.org \
)
echo $i
$i
end

date
