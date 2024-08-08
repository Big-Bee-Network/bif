#!/bin/bash
#
#

cat review.tsv.gz\
  | gunzip\
  | cut -f15\
  | grep "{"\
  | jq -c 'select(.reviewCommentType == "note")'\
  | grep "found unsupported interaction type with name:"\
  | jq --raw-output '[.namespace, .reviewComment] | @tsv'\
  | sed -E "s/\t.*\[/\t/g"\
  | tr -d ']'

