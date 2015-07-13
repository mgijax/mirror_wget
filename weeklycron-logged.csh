#!/bin/csh -f

#
# Wrapper for mirroring weekly files that need to be logged in RADAR.
#

cd `dirname $0` && source ./Configuration

date

# mirror the files
foreach i (\
ftp.ncbi.nih.gov.gbNC \
ftp.ncbi.nih.gov.gbTpaNC \
ftp.ncbi.nih.gov.refseqDaily \
ftp.ncbi.nih.gov.gbDel \
)
echo $i
$i
end

# now log the GenBank/RefSeq files in RADAR
${RADAR_DBUTILS}/bin/logFileToProcessByDir.csh ${RADAR_DBSCHEMADIR} ${DATADOWNLOADS}/genbank_daily ${DATADOWNLOADS}/genbank_daily GenBank_preprocess
${RADAR_DBUTILS}/bin/logFileToProcessByDir.csh ${RADAR_DBSCHEMADIR} ${DATADOWNLOADS}/ftp.ncbi.nih.gov/refseq/daily ${DATADOWNLOADS}/ftp.ncbi.nih.gov/refseq/daily RefSeq_preprocess
${RADAR_DBUTILS}/bin/logFileToProcessByDir.csh ${RADAR_DBSCHEMADIR} ${DATADOWNLOADS}/grendel.jax.org/TPA/non-cumulative ${DATADOWNLOADS}/grendel.jax.org/TPA/non-cumulative GenBank_preprocess

date
