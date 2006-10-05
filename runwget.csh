#!/bin/csh -f

#
# Program: runwget.csh
#
# Original Author: Lori Corbani
#
# Purpose:
#
#	Wrapper for GNU "wget" utility.
#	Allows us to configure a suite of URLs for
#	downloading into /data/downloads on a daily,
#	weekly or monthly basis.
#
# Requirements Satisfied by This Program:
#
# Usage:
#
# Envvars:
#
# Inputs:
#
# Outputs:
#
# Exit Codes:
#
# Assumes:
#
# Bugs:
#
# Implementation:
#
#	This is a quick and dirty version.
#	It basically just calls "wget" with some pre-defined options.
#
# Modification History:
#
# 11/13/2003	lec
#	- TR 5310; new
#

cd `dirname $0` && source ./Configuration && cd ${DATADIR}

setenv URL	$1
setenv LOGFILE	$2

#
# -r = overwrite existing copy with new copy
# -x = force file to be saved in URL directory hierarchy
# -S = print the headers sent by HTTP servers and responses sent by FTP servers.
# -N = turn on time stamping (so file doesn't get downloaded if no changes)
# -t = number of retries
#

wget -o ${MIRRORLOG}/${LOGFILE}.log -rxNS -t 10 ${URL}

