#!/bin/bash
#
# Do streaming review of datasets
# with possible biotic interactions.
#

set -x 

./find-datasets-with-interactions.sh\
 | sort\
 | uniq\
 | tee datasets.json\
 | elton stream --record-type review\
 | gzip\
 > review.tsv.gz
