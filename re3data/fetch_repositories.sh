#!/bin/bash
#
# fetch all re3data repositories and request each of them.
#
# v0.0.1, Andreas Czerniak
#
# requirements:
# * curl
# * date
# * sed
# * xmlstarlet

ADATE=`date +%Y%m%d`
AYEAR=`date +%Y`
AMONTH=`date +%m`
ADAY=`date +%d`

SAVEDATA="./data/${AYEAR}/${AMONTH}"

mkdir -p ${SAVEDATA}
curl --silent 'https://www.re3data.org/api/v1/repositories' > ${SAVEDATA}/${ADATE}_repositories.xml

RE3DATA=`xmlstarlet sel -t -v '//link/@href' ${SAVEDATA}/${ADATE}_repositories.xml | sed 's#/api/v1/repository/##' `

mkdir -p ${SAVEDATA}/${ADAY}
for re3 in ${RE3DATA}; do

  echo -n "${re3}:"
  curl --silent https://www.re3data.org/api/v1/repository/${re3} > ${SAVEDATA}/${ADAY}/${re3}.xml
  echo "...done."

  # make it fair
  sleep 1.3

done

