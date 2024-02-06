#!/bin/bash
set -euo pipefail

query=institutions.rq

curl -s --data-urlencode "query@$query" https://query.wikidata.org/sparql?format=json | \
    jq .results.bindings[]
