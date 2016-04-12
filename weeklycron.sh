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
# Source mgiconfig master config file
MGICONFIG=/usr/local/mgi/live/mgiconfig
if [ ! -f $MGICONFIG/master.config.sh ]
then
  echo "$MGICONFIG/master.config.sh main Configuration file is missing"
  exit 1
fi
. $MGICONFIG/master.config.sh
SCRIPT_NAME=`basename $0`
MIRRORLOG=${DATADOWNLOADS}/mirror_wget_logs

date

FILES="ftp.nextprot.org.nextprot 
ftp.ncbi.nih.gov.unigene
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
ftp.xenbase.org.downloads
mygene.info.wikipedia
data.omim.org.omim
purl.obolibrary.org.hp.obo"

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
log_report=$MIRRORLOG/$SCRIPT_NAME.log
./check_mirror_logs.sh $log_report "$LOG_FILES"
date 

