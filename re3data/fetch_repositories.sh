#!/bin/bash
#
# fetch all re3data repositories and request each of them.
#
# v0.0.1, Andreas Czerniak
#
# requirements:
# * curl
# * sed
# * xmlstarlet

ADATE=`date +%Y%m%d`
AYEAR=`date +%Y`
AMONTH=`date +%m`

SAVEDATA="./data/${AYEAR}/${AMONTH}"

mkdir -p ${AYEAR}/${AMONTH}
curl --silent 'https://www.re3data.org/api/v1/repositories' > ${SAVEDATA}/${ADATE}_repositories.xml

RE3DATA=`xmlstarlet sel -t -v '//link/@href' ${SAVEDATA}/${ADATE}_repositories.xml | sed 's#/api/v1/repository/##' `

for re3 in ${RE3DATA}; do

  echo -n "${re3}:"
  curl --silent https://www.re3data.org/api/v1/repository/${re3} > ${SAVEDATA}/${ADATE}/${re3}.xml
  echo "...done."

  # make it fair
  sleep 1.3

done

