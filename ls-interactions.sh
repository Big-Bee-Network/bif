#!/bin/bash
#
#

./find-datasets-with-interactions.sh\
 | elton stream\
 | pv -l\
 | gzip > interactions.tsv.gz

