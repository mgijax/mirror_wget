#!/bin/csh -f

#
# Wrapper for running weekly crons
#
# Usage:  weeklycron.csh
#
# History
#
# 02/25/2015 - sc TR11888
#	- added ftp.xenbase.org
#
# 01/28/2015 sc
#	- renamed www.zfin.* zfin.*
#
# 01/13/2015 sc
#	- Added www.geisha* - TR11887
#
# 01/07/2015 sc
#	- Added www.zfin.gene.org, www.zfin.xpat.org, www.mouse_orthos.org
#	- TR11721
#
# 12/17/2014 kstone
#	- Added allStrains.csv imsr report for postgres conversion of 
#		qcreports and public reports
#
# 10/08/2014
#       - TR11674 added ftp.ebi.ac.uk
#
# 09/05/2014	lec
#	- TR11654/add geisha.arizona.edu
#	- TR11654/add www.zfin.org
#
# 08/20/2014
#       -TR11674/add www.i-dcc.org_imits, www.ebi.ac.uk
#
# 03/21/2014
#	- TR11615/add emnet.informatics.jax.org2
#
# 02/07/2014
#	- TR11515/add emnet.informatics.jax.org:48080
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
emnet.informatics.jax.org:48080 \
emnet.informatics.jax.org2 \
zfin.gene.org \
zfin.mouse_orthos.org \
zfin.xpat.org \
geisha.arizona.expr.edu \
geisha.arizona.orthos.edu \
)
set URL=`cut -f1 $i`
set LOG=`cut -f2 $i`
echo $i
runwget.csh ${URL} ${LOG}
end

#remove temporarily
#www.europhenome.org \
foreach i (\
emnet.informatics.jax.org3 \
www.genenames_hgnc.org \
www.i-dcc.org2 \
www.i-dcc.org3 \
www.sanger.ac.uk5 \
www.mousephenotype.org \
www.i-dcc.org_imits \
www.ebi.ac.uk \
ftp.ebi.ac.uk \
ftp.xenbase.org \
)
echo $i
$i
end

date
