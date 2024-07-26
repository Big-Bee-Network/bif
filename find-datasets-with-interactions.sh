#!/bin/bash
#
# selects datasets that contains one of more interaction claims.
#

VERSION_ANCHOR=${1:-"hash://sha256/37bdd8ddb12df4ee02978ca59b695afd651f94398c0fe2e1f8b182849a876bb2"}
REMOTES="https://linker.bio"

preston cat --no-cache --remotes "${REMOTES}" ${VERSION_ANCHOR}\
 | grep -E "(application/dwca|hasVersion)"\
 | grep --after 1 "application/dwca"\
 | grep hasVersion\
 | grep -Eo "hash://[a-z0-9]+/[a-f0-9]+"\
 | sed -E "s/([a-f0-9]+)$/\1\t\1/g"\
 | awk -F '\t' '{ print "{ \"namespace\": \"" $1 "\", \"citation\": \"" $1 "\", \"format\": \"dwca\", \"url\": \"https://linker.bio/" $1 "\" }" }'
