\name{mol.sum}
\alias{mol.sum}

\title{
Mapping and summation of molecular data onto standard IDs
}
\description{
Molecular data like gene or metabolite data are frequently annotated by
various types of IDs. This function maps and summarize molecular data
onto standard gene or compound IDs. It would be straightforward to
integrate, analyze or visualize the "standardized" data with pathways or
functional categories.
}
\usage{
mol.sum(mol.data, id.map, gene.annotpkg = "org.Hs.eg.db", sum.method =
c("sum", "mean", "median", "max", "max.abs", "random")[1])
}
%- maybe also 'usage' for other objects documented here.
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
  \item{id.map}{
a two-column character matrix, giving the mapping between molecular IDs
used in mol.data and taget/standard molecular IDs. Then mol.data are
gene data, \code{id.map} may also be a character specifying the type of
IDs used in mol.data. The two-column mapping matrix will be generated
automatically.
}
  \item{gene.annotpkg}{
character, name of the gene annotation package. This package should be
one of the standard annotation packages from Bioconductor, such as
"org.Hs.eg.db" (default). Check \code{data(bods); bods} for a full list of standard
annotation packages. You may also use your custom annotation package
built with AnnotationDbi, the Bioconductor Annotation Database
Interface. Only effective when mol.data are gene.data and id.map gives
the ID type being used.
}
  \item{sum.method}{
  character, the method name to calculate node summary given that
  multiple genes or compounds are mapped to it. Poential options include
  "sum","mean", "median", "max", "max.abs" and "random". Default sum.method="sum".
}
}
\details{
This function is called in pathview main function when gene.idtype or
cpd.idtype is not the standard type, so that the molecular data can be
mapped and summarized onto standard IDs. This is needed for further
mapping to KEGG pathways. The same standard ID mapping is needed when
carry out pathway or functional analysis on molecular data, which are
labeled by non-standard (or alien) IDs or probe names, like in most of
the microarray or metabolomics datasets. In other words, function
\code{mol.sum} can be useful in all these situations.
}
\value{
a numeric vector or matrix. Its dimensionality is the same as the input
mol.data except row names are standard molecular IDs.
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
  \code{\link{node.map}} the node data mapper function.
  \code{\link{id2eg}}, \code{\link{cpd2kegg}} etc the auxillary molecular ID mappers,
  \code{\link{pathview}} the main function,
}
\examples{
data(gene.idtype.list)
#generate simulated gene data named with non-KEGG/Entrez gene IDs
gene.ensprot <- sim.mol.data(mol.type = "gene", id.type = gene.idtype.list[4], 
    nmol = 50000)
#construct map between non-KEGG ID and KEGG ID (Entrez gene)
id.map.ensprot <- id2eg(ids = names(gene.ensprot), 
    category = gene.idtype.list[4], org = "Hs")
#Map molecular data onto Entrez Gene IDs
gene.entrez <- mol.sum(mol.data = gene.ensprot, id.map = id.map.ensprot)
#check the results
head(gene.ensprot)
head(id.map.ensprot)
head(gene.entrez)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
