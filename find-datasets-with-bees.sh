#!/bin/bash
#
# selects records that refer to a scientificName that discoverlife recognizes
#

VERSION_ANCHOR=${1:-"hash://sha256/37bdd8ddb12df4ee02978ca59b695afd651f94398c0fe2e1f8b182849a876bb2"}
REMOTES="https://linker.bio"

preston cat --no-cache --remotes "${REMOTES}" ${VERSION_ANCHOR}\
 | grep -E "(application/dwca|hasVersion)"\
 | grep --after 1 "application/dwca"\
 | preston dwc-stream --no-cache --remote "${REMOTES}"\
 | jq --raw-output '[.["http://rs.tdwg.org/dwc/terms/scientificName"],.["http://www.w3.org/ns/prov#wasDerivedFrom"]] | @tsv'\
 | sed 's/^/\t/g'\
 | nomer append discoverlife\
 | grep -v NONE\
 | cut -f3\
 | grep -Eo "hash://[a-z0-9]+/[a-f0-9]+"\
 | uniq

