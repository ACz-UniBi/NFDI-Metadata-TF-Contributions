#!/bin/bash
#
# count all re3data repositories.
#
# v0.0.1
#
#
set -euo pipefail

today=`date +%Y%m%d`
date=${1:-$today}

if [[ ! "$date" =~ ^20[0-9]{6}$ ]]; then
  echo "Usage: $0 YYYYMMDD"
  exit 1
fi

year=${date:0:4}
month=${date:4:2}
day=${date:6:2}

dir=./data/$year/$month
repos=${dir}/${date}_repositories.xml

if [[ -f "$repos" ]]; then
  echo -n "$year-$month-$day,"
  grep '</repository>' "$repos"  | wc -l
else
  echo 1>&2 "Missing $repos"
  exit 1
fi
