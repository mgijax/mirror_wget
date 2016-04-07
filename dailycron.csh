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
setenv LOG_FILES ""

# Run 
foreach package (\
www.sequenceontology.org.current_release.obo \
www.genetrap.org.igtc  \
build.berkeleybop.org.gaf-check-mgi \
purl.obolibrary.org.go-basic.obo \
purl.obolibrary.org.cl-basic.obo \
purl.obolibrary.org.ma.obo \
purl.obolibrary.org.emap.obo \
purl.obolibrary.org.eco.obo \
purl.obolibrary.org.mod.obo \
purl.obolibrary.org.uberon.obo \
www.gensat.org.EntrezGeneIds \
ftp.ebi.ac.uk.goa \
ftp.ebi.ac.uk.interpro \
ftp.ebi.ac.uk.arrayexpress \
# From ftp mirrors daily\
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
download_package  $package 
setenv LOG_FILES "$LOG_FILES $MIRRORLOG/$package.log"
end

set SCRIPT_NAME=`basename $0`
#Check logs for errors
echo "Running sanity check on $LOG_FILES"
setenv log_report $MIRRORLOG/$SCRIPT_NAME.log

./check_mirror_logs.sh $log_report "$LOG_FILES"

date
