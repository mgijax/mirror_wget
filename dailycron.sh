#!/bin/sh 

#
# This is the main script to run daily mirror downloads.
#
# Usage:  dailycron.sh
#
# History
#
# 04/05/2016 lnh
#  TR12266 : Migrate mirror_ftp to mirror_wget
#
# 11/13/2003    lec
#       - TR 5310; new
#
#
# Source mgiconfig master config file
cd `dirname $0`
WORKING_DIR=`pwd`
SCRIPT_NAME=`basename $0`
#
# Check if the main config file exists
#
MAIN_CONFIG=$WORKING_DIR/Configuration

if [ ! -r $MAIN_CONFIG ]
then
  echo "The main Configuration file is missing from $WORKING_DIR"
  echo "Run the Install script "
  exit 1
fi
# source the main config file
. ${MAIN_CONFIG}

date

FILES="www.sequenceontology.org.current_release.obo 
www.genetrap.org.igtc  
build.berkeleybop.org.gaf-check-mgi 
purl.obolibrary.org.go-basic.obo 
purl.obolibrary.org.cl-basic.obo 
purl.obolibrary.org.ma.obo 
purl.obolibrary.org.emap.obo 
purl.obolibrary.org.eco.obo 
purl.obolibrary.org.mod.obo 
purl.obolibrary.org.uberon.obo 
www.gensat.org.EntrezGeneIds 
ftp.ebi.ac.uk.goa 
ftp.ebi.ac.uk.interpro 
ftp.ebi.ac.uk.arrayexpress 
ftp.hgu.mrc.ac.uk.emage 
ftp.sanger.ac.uk.vega_prot 
ftp.sanger.ac.uk.vega_cdna 
ftp.sanger.ac.uk.vega_gtf 
ftp.sanger.ac.uk.vega_ncrna
ftp.pir.georgetown.edu.iproclass 
ftp.pir.georgetown.edu.pro_ids 
ftp.ncbi.nih.gov.unigene 
ftp.ncbi.nih.gov.entrez_gene 
ftp.ncbi.nih.gov.homologene 
ftp.ncbi.nih.gov.ccds 
ftp.ncbi.nih.gov.mapview"

LOG_FILES=""
for package in $FILES
do 
    echo "Downloading  $package"
    LOG_FILES="$LOG_FILES  $MIRRORLOG/$package.log"
    ./download_package $package
done

#Check logs for errors
echo "Starting sanity check on $LOG_FILES"
log_report="$MIRRORLOG/$SCRIPT_NAME.check_mirror_logs.sh.log"
./check_mirror_logs.sh $log_report "$LOG_FILES"

date 
