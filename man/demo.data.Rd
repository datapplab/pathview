\name{demo.data}
\alias{demo.paths}
\alias{gse16873.d}
\alias{paths.hsa}
\docType{data}
\title{
  Data for demo purpose
}
\description{
demo.paths includes pathway ids and optimal plotting parameters when
calling pathview.

GSE16873 is a breast cancer study (Emery et al, 2009) downloaded from
Gene Expression Omnibus (GEO). Dataset gse16873 is pre-processed using FARMS
method and includes 6 patient cases,
each with HN (histologically normal) and DCIS (ductal carcinoma in situ)
 RMA samples. The same dataset is also used in \code{gage}
 package. Dataset gse16873.d includes the gene expression changes of two
 pairs of DCIS vs HN samples.

paths.hsa includes the full list of human pathway ID/names from KEGG.
}
\usage{
data(demo.paths)
data(gse16873.d)
data(paths.hsa)
}
\format{
  demo.paths is a named list with ids and plotting parameters for 3
  pathways. For details do:

  \code{data(demo.paths); demo.paths}
  
  gse16873.d is a numeric matrix with over 10000 rows (genes) and 2
  columns (samples). For details do:
  \code{data(gse16873.d); str(gse16873.d)}.

  paths.hsa is a named vector mapping KEGG pathway ID to human pathway names.
}
\source{
  http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE16873
}
\keyword{datasets}
