\name{korg}
\alias{korg}
\alias{bods}
\docType{data}
\title{
  Mapping data on KEGG species code and corresponding Bioconductor gene
  annotation package
}
\description{

  Data on KEGG species, including taxonomy IDs, KEGG code, scientific name,
  common name, corresponding gene ID types, and gene annotation package
  names in Bioconductor
}
\usage{
data(korg)
data(bods)
}
\format{
  korg is a character matrix of ~4800 rows and 10 columns. First 5
  columns are KEGG and NCBI taxonomy IDs, KEGG species code, scientific
  name and common name, followed columns on gene ID types used for each
  species: entrez.gnodes ("1" or "0", whether EntrezGene is the default
  gene ID) and representative KEGG gene ID, NCBI or Entrez Gene ID, NCBI
  protein and Uniprot ID. Note korg includes 4800 KEGG species (as of
  06/2017), in the meantime, an updated version of korg is now checked
  out from Pathview Web server each time pathview package is loaded.

  
  bods is a character matrix of 19 rows and 3 columns on the mapping
  between gene annotation package names in Bioconductor, common name and
  KEGG code of most common research species.
}
\source{
  http://www.genome.jp/kegg-bin/get_htext?br08601.keg

  http://bioconductor.org/packages/release/BiocViews.html#___OrgDb
}
\examples{
data(korg)
data(bods)
head(korg)
head(bods)
}
\keyword{datasets}
