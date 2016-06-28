#!/bin/sh 

#
# This script runs weekly.
# Usage:  weeklycron.sh
#
# History
#
# 04/05/2016 lnh
#    TR12266 : Migrate mirror_ftp to mirror_wget
#
# History
#
# 11/11/2013    lec
#       - TR 11536/replace 'grcf.jhmi.edu' with 'ftp.omim.org'
#
# 06/14/2013    sc
#       - TR11353 Infrastructure I project; rm occams.dfci.harvard.edu
#
# 04/27/2011    lec
#       - TR 10551/add grcf.jhmi.edu
#
# 11/13/2009    sc
#       - TR9729; added occams.dfci.harvard.edu
#
# 04/18/2003    lec
#       - TR 4650; new
#
# 01/04/2010    sc
#       - removed ftp.pir.georgetown.edu  to daily
#

cd `dirname $0` 
#
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

FILES="ftp.nextprot.org.nextprot 
ftp.ncbi.nih.gov.entrez_gene
ftp.ncbi.nih.gov.homologene
ftp.ncbi.nih.gov.ccds
ftp.ncbi.nih.gov.mapview
ftp.ensembl.org.mouse_ncrna
ftp.ensembl.org.mouse_cdna
ftp.ensembl.org.mouse_prot
ftp.ensembl.org.mouse_gtf
www.findmice.org.imsrwi
zfin.org.downloads
geisha.arizona.edu.geisha
compbio.charite.de.phenotype_annotation
emnet.informatics.jax.org.imsr_allStrains
www.mousephenotype.org.reports
www.ebi.ac.uk.impc.json
ftp.ebi.ac.uk.sprot
ftp.ebi.ac.uk.trembl
ftp.xenbase.org.downloads
mygene.info.wikipedia
data.omim.org.omim
purl.obolibrary.org.hp.obo
ftp.pir.georgetown.edu.pirsfload
ftp.pir.georgetown.edu.proload"
#
#disabled
#www.genenames.org.hgnc
#
LOG_FILES=""
for package in $FILES
do 
    echo "Downloading  $package"
    LOG_FILES="$LOG_FILES $MIRRORLOG/$package.log"
    ./download_package $package
done

date
#Check logs for errors
echo "Running sanity check on $LOG_FILES"
log_report="$MIRRORLOG/$SCRIPT_NAME.check_mirror_logs.sh.log"
./check_mirror_logs.sh $log_report "$LOG_FILES"
date 
