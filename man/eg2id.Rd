\name{eg2id}
\alias{eg2id}
\alias{id2eg}
\alias{geneannot.map}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Mapping between different gene ID and annotation types
}
\description{
These auxillary gene ID mappers connect different gene ID or annotation
types, especially they are used to map Entrez Gene ID to external gene,
transcript or protein IDs or vise versa. 
}
\usage{
eg2id(eg, category = gene.idtype.list[1:2], org = "Hs", pkg.name = NULL,
...)
id2eg(ids, category = gene.idtype.list[1], org = "Hs", pkg.name = NULL, ...)
geneannot.map(in.ids, in.type, out.type, org="Hs", pkg.name=NULL,
unique.map=TRUE, na.rm=TRUE, keep.order=TRUE)
}
\arguments{
  \item{eg}{
character, input Entrez Gene IDs.
}
  \item{ids}{
character, input gene/transcript/protein IDs to be converted to Entrez
Gene IDs.
}
  \item{in.ids}{
character, input gene/transcript/protein IDs to be converted or mapped
to other Gene IDs or annotation types.
}
  \item{category}{
character, for \code{eg2id} the output ID types to map from Entrez Gene,
d to be c("SYMBOL", "GENENAME"); for \code{id2eg}, the input ID type  to
be mapped to Entrez Gene, default to be "SYMBOL".
}
  \item{in.type}{
character, the input gene/transcript/protein ID type  to be mapped or
converted to other ID/annotation types. 
}
  \item{out.type}{
character, the output gene/transcript/protein ID type  to be mapped or
converted to other ID/annotation types. 
}
  \item{org}{
character, the two-letter abbreviation of organism name, or KEGG species
code, or the common species name, used to determine the gene annotation
package. For all potential values check:  \code{data(bods);
  bods}. Default org="Hs", and can also be "hsa" or "human" (case
insensitive). Only effective when pkg.name is not NULL.
}
  \item{pkg.name}{
character, name of the gene annotation package. This package should be
one of the standard annotation packages from Bioconductor, such as
"org.Hs.eg.db". Check \code{data(bods); bods} for a full list of standard
annotation packages. You may also use your custom annotation package
built with AnnotationDbi, the Bioconductor Annotation Database
Interface. Default pkg.name=NULL, hence argument \code{org} should be
specified.
}
  \item{unique.map}{
logical, whether to combine multiple entries mapped to the same input ID
as a single entry (separted by "; "). Default unique.map=TRUE.
}
  \item{na.rm}{
logical, whether to remove the lines where input ID is not mapped (NA
for mapped entries). Default na.rm=TRUE.
}
  \item{keep.order}{
logical, whether to keep the original input order even with all unmapped
input IDs. Default keep.order=TRUE.
}
  \item{\dots}{
    other arguments to be passed to geneannot.map function.
  }
}
\details{
KEGG uses Entrez Gene ID as its standard gene ID. Therefore, all gene
data need to be mapped to Entrez Genes when working with KEGG
pathways. Function \code{id2eg} does this mapping. On the other hand, we
frequently want to check or show gene symbols or full names instead of
the less informative Entrez Gene ID when working with KEGG gene nodes,
Function \code{eg2id} does this reverse mapping. Both \code{id2eg} and
\code{eg2id} are wrapper functions of \code{geneannot.map} function. The
latter can be used to map between a range of major
gene/transcript/protein IDs or annotation types, not just Entrez Gene ID.
These functions are written as part of the Pathview mapper module, they
are equally useful for other gene ID or data mapping tasks.
The use of these functions depends on gene annotation packages like
"org.Hs.eg.db", which are Bioconductor standard. IFf no such packages not available for
your interesting organisms, you may build one with Bioconductor
AnnotationDbi package.
}
\value{
a 2- or multi-column character matrix recording the mapping between input IDs to
the target ID type(s).
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
  \code{\link{cpd2kegg}} etc the auxillary compound ID mappers,
  \code{\link{mol.sum}} the auxillary molecular data mapper,
  \code{\link{node.map}} the node data mapper function.
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

#map Entrez Gene to Gene Symbol and Name
eg.symbname=eg2id(eg=id.map.ensprot[,2])
#entries with more than 1 Entrez Genes are not mapped
head(eg.symbname)

#not run: map between other ID types for other species
#ath.tair=sim.mol.data(id.type="tair", species="ath", nmol=1000)
#data(gene.idtype.bods)
#gid.map <-geneannot.map(in.ids=names(ath.tair)[rep(1:100,each=2)],
#in.type="tair", out.type=gene.idtype.bods$ath[-1], org="At")
#gid.map1 <-geneannot.map(in.ids=names(ath.tair)[rep(1:100,each=2)],
#in.type="tair", out.type=gene.idtype.bods$ath[-1], org="At",
#unique.map=F, keep.order=F)
#str(gid.map)
#str(gid.map1)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
