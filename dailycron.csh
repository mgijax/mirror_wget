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
purl.obolibrary6.org \
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

# From ftp mirrors daily
foreach i (\
ftp.hgu.mrc.ac.uk.emage \
ftp.sanger.ac.uk.vega_prot \
ftp.sanger.ac.uk.vega_cdna \
ftp.sanger.ac.uk.vega_gtf \
ftp.mirbase.org.mirbase \
ftp.pir.georgetown.edu.iproclass \
ftp.pir.georgetown.edu.pro_ids \
ftp.ncbi.nih.gov.unigene \
ftp.ncbi.nih.gov.entrez_gene \
ftp.ncbi.nih.gov.homologene \
ftp.ncbi.nih.gov.ccds \
ftp.ncbi.nih.gov.mapview \
)
download_package  $i 
end


date
