#!/bin/bash
#
# count repositories from overview list
#
# v0.0.1, Andreas Czerniak
#
# requirements:
# * date
# * grep
# * wc

ADATE=`date +%Y%m%d`
if [ ! -z "$1" ]; then
  ADATE="$1"
fi
AYEAR=`date +%Y`
AMONTH=`date +%m`
MYDATE=`date +%Y-%m-%d`

SAVEDATA="./data/${AYEAR}/${AMONTH}"

COUNTREPO=`grep '</repository>' ${SAVEDATA}/${ADATE}_repositories.xml | wc -l`

echo "${MYDATE},${COUNTREPO}"
