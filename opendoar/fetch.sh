#!/bin/bash
#
# Documentation of OpenDOAR / Sherpa API provided by JISC UK: https://v2.sherpa.ac.uk/api/
#
# params:
#  * baseURL:  https://v2.sherpa.ac.uk/cgi/retrieve
#  * queryParams: api-key=$ODAPIKEY&item-type=repository&order=id&format=Json&limit=100
#  * resumptionParam: offset
#
# 0.0.1 ; 2024-04-25 ; Andreas Czerniak ; initial version based on harvesting of records for OpenAIRE back in 2019
#

if [ ! -f ODAPIKEY.txt ] ; then
  echo "please create first a file named: ODAPIKEY.txt"
  echo "with your OpenDOAR apikey to continue ; visit https://v2.sherpa.ac.uk/api/ for further details"
  exit 2
fi

APIKEY=`cat ODAPIKEY.txt`
USERAGENT="PID-Network develop env./mailto=pid-monitor@uni-bielefeld.de"  # to be fair, please change
OFFSET=0
MYCOUNT=100
MAXCOUNT=100

SAVEDATAPATH="./data/$(date +%Y)/$(date +%m)/$(date +%d)"
mkdir -p $SAVEDATAPATH

while [ ${MAXCOUNT} -eq ${MYCOUNT} ]
do

  curl --user-agent ${USERAGENT} \
    "https://v2.sherpa.ac.uk/cgi/retrieve?api-key=${APIKEY}&item-type=repository&order=id&limit=100&format=Json&offset=${OFFSET}" \
    > $SAVEDATAPATH/od$(printf "%05d\n" ${OFFSET}).json

  MYCOUNT=`jq '. | .items | length' $SAVEDATAPATH/od$(printf "%05d\n" ${OFFSET}).json `

  OFFSET=$(( OFFSET + 100))

done
