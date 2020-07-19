\name{sim.mol.data}
\alias{sim.mol.data}

\title{
Simulate molecular data for pathview experiment
}
\description{
The molecular data simulator generates either gene.data or cpd.data of
different ID types, molecule numbers, sample sizes, either
continuous or discrete.
}
\usage{
sim.mol.data(mol.type = c("gene", "gene.ko", "cpd")[1], id.type = NULL,
species="hsa", discrete = FALSE, nmol = 1000, nexp = 1, rand.seed=100)
}

\arguments{
  \item{mol.type}{
character of length 1, specifing the molecular type, either "gene" (including
transcripts, proteins), or "gene.ko" (KEGG ortholog genes, as defined in
  KEGG ortholog pathways), or "cpd" (including metabolites, glycans,
  drugs). Note that KEGG ortholog gene are considered "gene" in function
  \code{pathview}. Default mol.type="gene".
}
  \item{id.type}{
    character of length 1, the molecular ID type. When mol.type="gene",
  proper ID types include "KEGG" and "ENTREZ" (Entrez Gene). Multiple other ID
  types are also valid When species is among 19 major species fully
  annotated in Bioconductor, e.g. "hsa" (human), "mmu" (mouse) etc, check:

    \code{data(gene.idtype.bods); gene.idtype.bods} for
  other valid ID types. When mol.type="cpd", check \code{data(cpd.simtypes);
  cpd.simtypes} for valid ID types. Default id.type=NULL, then "Entrez" and
  "KEGG COMPOUND accession" will be assumed for mol.type = "gene" or
  "cpd".
}
  \item{species}{
character, either the kegg code, scientific name or the common name of
the target species. This is only effective when mol.type =
  "gene". Setting species="ko" is equilvalent to
  mol.type="gene.ko". Default species="hsa", equivalent to either "Homo
  sapiens" (scientific name) or "human" (common name). Gene data id.type
  has multiple other choices for 19 major research species, for details
  do: \code{data(gene.idtype.bods); gene.idtype.bods}. When other
  species are specified, gene id.type is limited to "KEGG" and "ENTREZ".
  }
  \item{discrete}{
logical, whether to generate discrete or continuous data. d
  discrete=FALSE, otherwise, mol.data will be a charactor vector of
  molecular IDs.
}
  \item{nmol}{
integer, the target number of different molecules. Note that the
  specified id.type may not have as many different IDs as nmol. In this
  case, all IDs of id.type are used.
}
  \item{nexp}{
integer, the sample size or the number of columns in the result
  simulated data.
}
  \item{rand.seed}{
numeric of length 1, the seed number to start the random sampling
  process. This argumemnt makes the simulation reproducible as long as
  its value keeps the same. Default rand.seed=100. 
}
}
\details{
This function is written mainly for simulation or experiment with
  pathview package. With the simulated molecular data, you may check
  whether and how pathview works for molecular data of different types,
  IDs, format or sample sizes etc. You may also generate both gene.data
  and cpd.data and check data pathway based integration with pathview.
}
\value{
    either vector (single sample) or a matrix-like data (multiple
  sample), depends on the value of \code{nexp}. Vector should be numeric
  with molecular IDs as names or it may also be character of molecular
  IDs depending on the value of \code{discrete}. Matrix-like data structure has molecules as
  rows and samples as columns. Row names should be molecular IDs.

  This returned data can be used directly as gene.data or cpd.data
  input of \code{pathview} main function.
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
  \code{\link{mol.sum}} the auxillary molecular data mapper,
  \code{\link{id2eg}}, \code{\link{cpd2kegg}} etc the auxillary molecular ID mappers,
  \code{\link{pathview}} the main function,
}
\examples{
#continuous compound data
cpd.data.c=sim.mol.data(mol.type="cpd", nmol=3000)
#discrete compound data
cpd.data.d=sim.mol.data(mol.type="cpd", nmol=3000, discrete=TRUE)
head(cpd.data.c)
head(cpd.data.d)
#continuous compound data named with "CAS Registry Number"
cpd.cas <- sim.mol.data(mol.type = "cpd", id.type = "CAS Registry Number", nmol = 10000)

#gene data with two samples
gene.data.2=sim.mol.data(mol.type="gene", nmol=1000, nexp=2)
head(gene.data.2)

#KEGG ortholog gene data
ko.data=sim.mol.data(mol.type="gene.ko", nmol=5000)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
