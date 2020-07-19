\name{cpd.accs}
\alias{cpd.accs}
\alias{cpd.names}
\alias{kegg.met}
\alias{ko.ids}
\alias{rn.list}
\alias{gene.idtype.list}
\alias{gene.idtype.bods}
\alias{cpd.simtypes}
\docType{data}
\title{
  Mapping data between compound or gene IDs and KEGG accessions
}
\description{
  Mapping data between compound or gene IDs and KEGG accessions
}
\usage{
data(cpd.accs)
data(cpd.names)
data(kegg.met)
data(ko.ids)
data(rn.list)
data(gene.idtype.list)
data(gene.idtype.bods)
data(cpd.simtypes)
}
\format{
  cpd.accs is a data frame with 30054 observations on the following 4 variables.
  cpd.names is a data frame with 12314 observations on the following 5
  variables.
  kegg.met is a character matrix of 694 rows and 3 columns.
  ko.ids is a character vector 8511 KEGG ortholog gene IDs, as used in
  KEGG ortholog pathways.
  rn.list is a namedlist of 21 vectors. Each vector records the row numbers
  for one of 21 dfferent compound ID types in cpd.accs data.frame.
  gene.idtype.list is a character vector of 13 common gene, transcript
  or protein ID types. Note some ID types are species specific, for
  example TAIR or ORF.
  gene.idtype.bods is a list of character vectors ofcommon gene, transcript
  or protein ID types for the 19 major research species in bods. Each
  element corresponds to a species.
  cpd.simtypes is a character vector of 7 common compound related ID
  types, each of them has over 1000 unique entries. Hence these ID types
  are good for generating simulation compound data.
}
\source{
  ftp://ftp.ebi.ac.uk/pub/databases/chebi/Flat_file_tab_delimited/

  http://www.genome.jp/kegg-bin/get_htext?br08001.keg
}
\examples{
data(cpd.accs)
data(rn.list)
names(rn.list)
cpd.accs[rn.list[[1]][1:4],]
lapply(rn.list[1:4], function(rn) cpd.accs[rn[1:4],])

data(kegg.met)
head(kegg.met)
}
\keyword{datasets}
