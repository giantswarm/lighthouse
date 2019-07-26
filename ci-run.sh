#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

readonly URL=$1

OUTPUT_FILE=/out/lighthouse.json

lighthouse \
  $URL \
  --output=json \
  --output-path=$OUTPUT_FILE \
  --emulated-form-factor desktop \
  --quiet \
  --chrome-flags="--headless --no-sandbox --ignore-certificate-errors"
  --plugins=lighthouse-plugin-greenhouse

if [[ ! -e $OUTPUT_FILE ]]; then
  echo "No lighthouse report written"
  exit 1
fi

if [ "$(cat $OUTPUT_FILE | jq -r '.runtimeError.code')" != "NO_ERROR" ]; then
  echo "Lighthouse exited with error: $(cat $OUTPUT_FILE | jq -r .runtimeError)"
  exit 2
fi

AUDITS="first-contentful-paint first-meaningful-paint speed-index interactive first-cpu-idle estimated-input-latency render-blocking-resources uses-responsive-images unminified-css unminified-javascript unused-css-rules uses-optimized-images total-byte-weight dom-size"

echo ""
echo "RESULTS FOR URL $URL"

echo ""
echo "-----------------------------"
echo "SELECTED AUDITS"
echo ""
for i in $AUDITS; do
  echo -n "$i: "
  echo $(cat $OUTPUT_FILE | jq '.["audits"] | .["'$i'"] | .["rawValue"]')
done

echo ""
echo "-----------------------------"
echo "SCORING"
echo ""
cat $OUTPUT_FILE | jq -r '.["categories"] | .[] | .["id"] + ": " + (.["score"] | tostring)' | sort

