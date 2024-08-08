#!/bin/bash
#
# Do streaming review of datasets
# with possible biotic interactions.
#

set -x 

DIST_DIR="dist/$(date --iso-8601=seconds)"

mkdir -p "${DIST_DIR}"

./find-datasets-with-interactions.sh\
 | sort\
 | uniq\
 | tee datasets.json\
 | elton stream --record-type review\
 | gzip\
 > "${DIST_DIR}/review.tsv.gz"

ln -f -s "${DIST_DIR}/review.tsv.gz" review.tsv.gz

