#!/bin/csh -f

#
# Wrapper for running monthly crons
#
# Usage:  monthlycron.csh
#
# History
#
# 11/06/2009	dbm
#	- New
#

cd `dirname $0` && source ./Configuration

date

foreach i (\
www.ebi.ac.uk \
)
$i
end

date
