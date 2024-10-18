[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.13272096.svg)](https://doi.org/10.5281/zenodo.13272096)


# bif
Biodiversity Interaction Finder (pronounced Bifi) - using Preston and Elton to detect bee interactions in existing biodiversity data infrastructures like GBIF/iDigBio/ALA etc. Slight modifications can be done to filter interactions based on any catalog.

# Methods 

## Workflow

0. discover GIB corpus versions [1] using 

```
preston history\
 --remote https://zenodo.org/records/7651831/files,https://linker.bio
``` 

1. pick a corpus version (e.g., https://linker.bio/hash://sha256/37bdd8ddb12df4ee02978ca59b695afd651f94398c0fe2e1f8b182849a876bb2, see also https://linker.bio)

1a. Find the most recent preston archive given an older one
 --preston head --anchor hash://sha256/37bdd8ddb12df4ee02978ca59b695afd651f94398c0fe2e1f8b182849a876bb2 --remote https://linker.bio

```
preston cat\
 --remote https://zenodo.org/records/7651831/files,https://linker.bio\
 hash://sha256/37bdd8ddb12df4ee02978ca59b695afd651f94398c0fe2e1f8b182849a876bb2
```

2. list all references to dwc-a content in that version

```
preston cat\
 --remote https://zenodo.org/records/7651831/files,https://linker.bio\
 hash://sha256/37bdd8ddb12df4ee02978ca59b695afd651f94398c0fe2e1f8b182849a876bb2\
 | grep --after 10 "application/dwca"\
 | grep hasVersion\
 | grep -Eo "hash://[a-z0-9]+/[a-f0-9]+" 
```

3a. detect interactions: for each dwc-a create a globi.json and do a review

globi.json

```
{ 
  "format": "dwca",
  "url" : "https://linker.bio/hash://sha256/69c839dc05a1b22d2e1aac1c84dec1cfd7af8425479053c74122e54998a1ddc2",
  "citation" : "hash://sha256/69c839dc05a1b22d2e1aac1c84dec1cfd7af8425479053c74122e54998a1ddc2"
}
```
  

3b. detect bees: 

For each dwc-a to detect whether there are bee names associated with the dwc-a

```
preston cat\
 --remote https://zenodo.org/records/7651831/files,https://linker.bio\
 hash://sha256/37bdd8ddb12df4ee02978ca59b695afd651f94398c0fe2e1f8b182849a876bb2\
 | grep --after 10 "application/dwca"\
 | grep hasVersion\
 | preston dwc-stream\
 | jq -c '{ "src": .["http://www.w3.org/ns/prov#wasDerivedFrom"], "name": .["http://rs.tdwg.org/dwc/terms/scientificName"] }'\
 | mlr --ijsonl --otsv cat\
 | nomer append discoverlife\
 | grep -v NONE\
 | grep -Eo "hash://[a-z0-9]+/[a-f0-9]+ 
```

4. make list of dwca that have at least one interaction (3a) *and* at least one bee name
5. for this list of dwca candidates, generate full reviews
6. concat the ```indexed-interactions.tsv.gz``` to create "BIF" archive.
7. publish the BIF archive ```indexed-interactions.tsv.gz``` to Zenodo 



# References

[1] Poelen, J. H. (2023). A biodiversity dataset graph: GBIF, iDigBio, BioCASe hash://sha256/450deb8ed9092ac9b2f0f31d3dcf4e2b9be003c460df63dd6463d252bff37b55 hash://md5/898a9c02bedccaea5434ee4c6d64b7a2 (0.0.4) [Data set]. Zenodo. https://doi.org/10.5281/zenodo.7651831
