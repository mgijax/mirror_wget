#!/bin/csh -f

#
# Wrapper for staging seqdb engine files
#
#
#

cd `dirname $0` && source ./Configuration

date

# standalone scripts
foreach i (\
ftp.ncbi.nih.gov.gbNC \
ftp.ncbi.nih.gov.gbTpaNC \
ftp.ncbi.nih.gov.refseqDaily \
ftp.ncbi.nih.gov.gbDel \
)
echo $i
$i
end

# now log the non cumulative and daily RefSeq files in RADAR
${RADAR_DBUTILS}/bin/logFileToProcessByDir.csh ${RADAR_DBSCHEMADIR} ${DATADOWNLOADS}/genbank_daily GB_NC GenBank_preprocess
${RADAR_DBUTILS}/bin/logFileToProcessByDir.csh ${RADAR_DBSCHEMADIR} ${DATADOWNLOADS}/ftp.ncbi.nih.gov/refseq/daily REFSEQ_DAILY_GB_FORMAT RefSeq_preprocess
${RADAR_DBUTILS}/bin/logFileToProcessByDir.csh ${RADAR_DBSCHEMADIR} ${DATADOWNLOADS}/grendel.jax.org/TPA/non-cumulative GB_TPA_NONCUM GenBank_preprocess

date
