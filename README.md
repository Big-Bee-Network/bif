# bif
Biodiversity Interaction Finder - using Preston and Elton to detect bee interactions in existing biodiversity data infrastructures like GBIF/iDigBio/ALA etc.

# Methods 

## Workflow

0. discover corpus versions using ```preston history --remote [some remote]``` (e.g., ```preston history --remote https://zenodo.org/records/7651831/files,https://linker.bio```)
1. pick a corpus version (e.g., https://linker.bio/hash://sha256/37bdd8ddb12df4ee02978ca59b695afd651f94398c0fe2e1f8b182849a876bb2, see also https://linker.bio)
2. list all dwc-a in that version
3a. detect interactions: for each dwc-a create a globi.json and do a review
3b. detect bees: for each dwc-a run ```preston dwc-stream | jq .["dwc:scientificName"] | nomer append discoverlife | grep -v NONE``` to detect whether there are bee names associated with the dwc-a
4. make list of dwca that have at least one interaction (3a) *and* at least one bee name
5. for this list of dwca candidates, generate full reviews
6. concat the ```indexed-interactions.tsv.gz``` to create "BIF" archive.
7. publish the BIF archive ```indexed-interactions.tsv.gz``` to Zenodo 
