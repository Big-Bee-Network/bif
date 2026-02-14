#!/bin/bash
# dwc validation embeded in elton to help identify which streaming files are dwc formatted.
#other record types name, review, default is interaction. Interaction is the tabular format. Similar to preston cat | elton interaction --prov-mode <- works for the output but not input yet (conceptual).

#run using  bash gib.sh > interactions.tsv 2>interactions.log

#conversation notes
#elton track --prov-mode globalbioticinteractions/ucsb-izc | elton tee | preston append looks for configuration on gbif and zenodo. If published version uses the published version
#preston head most recent version
#preston ls | grep "hasVersion" shows what preston is checking including all of globi community
#preston cat hash://sha256/37bdd8ddb12df4ee02978ca59b695afd651f94398c0fe2e1f8b182849a876bb2 | preston append <- adds dataset to my current configuration of ucsb-izc thus also using the interaction mapping file
#preston track also automatically appends
#run using bash gib.sh $(preston head) that changes anchor version to head

set -x
#TODO add inteaction type mapping 

VERSION_ANCHOR=${1:-"hash://sha256/37bdd8ddb12df4ee02978ca59b695afd651f94398c0fe2e1f8b182849a876bb2"}
REMOTES="https://linker.bio"
RECORD_TYPE="interactions"
RECORD_TYPE="review"

preston cat --remotes "${REMOTES}" ${VERSION_ANCHOR} \
 | elton stream \
 --record-type "${RECORD_TYPE}" \
 --data-dir data \
 --prov-dir data \
 --work-dir tmp \
 --no-cache \
 --remote "${REMOTES}"
