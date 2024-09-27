#!/bin/bash
#
# selects datasets that contains one of more interaction claims.
#
# example of starting point that is used here
# Poelen, J. H. (2023). A biodiversity dataset graph: GBIF, iDigBio, BioCASe hash://sha256/450deb8ed9092ac9b2f0f31d3dcf4e2b9be003c460df63dd6463d252bff37b55 hash://md5/898a9c02bedccaea5434ee4c6d64b7a2 (0.0.4) [Data set]. Zenodo. https://doi.org/10.5281/zenodo.7651831
# Or list of other starting points are found here: https://linker.bio/#use-case-3-studying-pine-pests-caused-by-weevils-curculionoidea

VERSION_ANCHOR=${1:-"hash://sha256/37bdd8ddb12df4ee02978ca59b695afd651f94398c0fe2e1f8b182849a876bb2"}
REMOTES="https://linker.bio"

preston cat --no-cache --remotes "${REMOTES}" ${VERSION_ANCHOR}\
 | grep -E "(application/dwca|hasVersion)"\
 | grep --after 1 "application/dwca"\
 | grep hasVersion\
 | grep -Eo "hash://[a-z0-9]+/[a-f0-9]+"\
 | sed -E "s/([a-f0-9]+)$/\1\t\1/g"\
 | awk -F '\t' '{ print "{ \"namespace\": \"" $1 "\", \"citation\": \"" $1 "\", \"format\": \"dwca\", \"url\": \"https://linker.bio/" $1 "\" }" }'
