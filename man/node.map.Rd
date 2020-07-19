\name{node.map}
\alias{node.map}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Map molecular data onto KEGG pathway nodes
}
\description{
  The mapper function, mapping molecular data(gene expression, metabolite
  abundance etc)to nodes in KEGG pathway. 
}
\usage{
node.map(mol.data = NULL, node.data, node.types = c("gene", "ortholog",
"compound")[1], node.sum = c("sum", "mean", "median", "max", "max.abs",
"random")[1], entrez.gnodes=TRUE)
}
\arguments{
  \item{mol.data}{
  Either vector (single sample) or a matrix-like data (multiple
  sample). Vector should be numeric with molecule IDs as names or it
  may also be character of molecule IDs. Character vector is treated as
  discrete or count data. Matrix-like data structure has molecules as
  rows and samples as columns. Row names should be molecule IDs. Default
  mol.data=NULL. 
  This argument is equivalent to gene.data or cpd.data in the pathview
  function. Check pahtview function for more information.
}
\item{node.data}{
a named list of 10 elements, the results returned by \code{node.info},
check the function for details.
}
  \item{node.types}{
character, sepcify the node type to map the mol.data to, either "gene",
"compound", or "compound". Default node.types="gene".
}
  \item{node.sum}{
  character, the method name to calculate node summary given that
  multiple genes or compounds are mapped to it. Poential options include
  "sum","mean", "median", "max", "max.abs" and "random". Default node.sum="sum".
}
  \item{entrez.gnodes}{
  logical, whether EntrezGene (NCBI GeneID) is used as the default gene
  ID in the KEGG data files. This is needed because KEGG uses different
  types default gene ID for different species. Some most common model
  species use EntrezGene, but majority of others use Locus tag. Default
  entrez.gnodes=TRUE.
}
}
\details{
Mapper function node.map maps user supplied molecular data to KEGG
pathways. This function takes standard KEGG molecular IDs (Entrez Gene
ID or KEGG Compound Accession) and map them to pathway nodes. None KEGG
molecular gene IDs or Compound IDs are pre-mapped to standard KEGG IDs
by calling another function \code{mol.sum}. When
multiple molecules map to one node, the corresponding molecular data are
summarized into a single node summary by calling function specified by
\code{node.sum}. This mapped node summary data together with the parsed
KGML data are then returned for further processing.
Proper input data include: gene expression, protein
expression, genetic association, metabolite abundance, genomic data,
literature, and other data types mappable to pathways.
The input mol.data may be NULL, then no molecular data are actually
mapped, but all nodes of the specified node.type are considered
"mappable" and their parsed KGML data returned.
}
\value{
  A data.frame composed of parsed KGML data and summary molecular data
  for each mapped node. Each row is a mapped node, and columns are:
  \item{kegg.names}{standard KEGG IDs/Names for mapped nodes. It's
    Entrez Gene ID or KEGG Compound Accessions.}
  \item{labels}{Node labels to be used when needed
  }
  \item{type}{node type, currently 4 types are supported:
    "gene","enzyme", "compound" and "ortholog".
  }
  \item{x}{x coordinate in the original KEGG pathway graph.
  }
  \item{y}{y coordinate in the original KEGG pathway graph.
  }
  \item{width}{node width in the original KEGG pathway graph.
  }
  \item{height}{node height in the original KEGG pathway graph.
  }
  \item{other columns }{columns of the mapped gene/compound data 
  }      
}
\references{
  Luo, W. and Brouwer, C., Pathview: an R/Bioconductor package for
  pathway based data integration and visualization. Bioinformatics,
 2013, 29(14): 1830-1831, doi: 10.1093/bioinformatics/btt285
}
\author{
  Weijun Luo <luo_weijun@yahoo.com>
}

\seealso{
  \code{\link{mol.sum}} the auxillary molecular data mapper,
  \code{\link{id2eg}}, \code{\link{cpd2kegg}} etc the auxillary molecular ID mappers,
  \code{\link{node.color}} the node color coder,
  \code{\link{pathview}} the main function,
  \code{\link{node.info}} the parser.
}
\examples{
xml.file=system.file("extdata", "hsa04110.xml", package = "pathview")
node.data=node.info(xml.file)
names(node.data)
data(gse16873.d)
plot.data.gene=node.map(mol.data=gse16873.d[,1], node.data,
  node.types="gene")
head(plot.data.gene)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
