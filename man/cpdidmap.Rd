\name{cpdidmap}
\alias{cpdidmap}
\alias{cpd2kegg}
\alias{cpdkegg2name}
\alias{cpdname2kegg}

\title{
Mapping between compound IDs and KEGG accessions
}
\description{
These auxillary compound ID mappers connect KEGG compound/glycan/drug
accessions to compound names/synonyms and other commonly used
compound-related IDs. 
}
\usage{
cpdidmap(in.ids, in.type, out.type)
cpd2kegg(in.ids, in.type)
cpdkegg2name(in.ids, in.type = c("KEGG", "KEGG COMPOUND accession")[1])
cpdname2kegg(in.ids)
}

\arguments{
  \item{in.ids}{
    character, input IDs to be mapped.
  }
  \item{in.type}{
    character, the input ID type, needs to be either "KEGG" (including
    compound, glycan and durg) or one of the
    compound-related ID types used in CHEMBL database. For a full list of
    the CHEMBL IDs, do \code{data(rn.list); names(rn.list)}. For
    \code{cpdkegg2name)}, default in.type = "KEGG".
  }
  \item{out.type}{
    character, the output ID type, needs to be either "KEGG" (including
    compound/glycan/durg) or one of the
    compound-related ID types used in CHEMBL database. For a full list of
    the CHEMBL IDs, do \code{data(rn.list); names(rn.list)}.
  }
}
\details{
character, the output ID type, needs to be either "KEGG" or one of the
  compound-related ID types used in CHEMBL database. For a full list of
  the CHEMBL IDs, do \code{data(rn.list); names(rn.list)}.

  KEGG has its own compound ID system, including compound (glycan/durg)
  accessions.  Therefore, all compound
data need to be mapped to KEGG accessions when working with KEGG
pathways. Function \code{cpd2kegg} does this mapping by calling
  \code{cpdname2kegg} or \code{cpdidmap}. On the other hand, we
frequently want to check or show compound full names or other commonly
  used IDs instead of the less informative KEGG accessions when working with KEGG compound nodes,
Functions \code{cpdkegg2name} and \code{cpdidmap} do this reverse mapping.
These functions are
written as part of the Pathview mapper module, they are equally useful
for other compound ID or data mapping tasks.
The use of these functions depends on a few data objects:
"cpd.accs", "cpd.names", "keg.met" and "rn.list", which are included in
  this package. To access them, use \code{data()} function.
}
\value{
a 2-column character matrix recording the mapping between input IDs to
the target ID type.
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
  \code{\link{eg2id}} and \code{\link{id2eg}} the auxillary gene ID mappers,
  \code{\link{mol.sum}} the auxillary molecular data mapper,
  \code{\link{node.map}} the node data mapper function.
}
\examples{
data(cpd.simtypes)
#generate simulated compound data named with non-KEGG ("CAS Registry Number")IDs
cpd.cas <- sim.mol.data(mol.type = "cpd", id.type = cpd.simtypes[2], 
    nmol = 10000)
#construct map between non-KEGG ID and KEGG ID ("KEGG COMPOUND accession")
id.map.cas <- cpdidmap(in.ids = names(cpd.cas), in.type = cpd.simtypes[2], 
    out.type = "KEGG COMPOUND accession")
#Map molecular data onto standard KEGG IDs
cpd.kc <- mol.sum(mol.data = cpd.cas, id.map = id.map.cas)
#check the results
head(cpd.cas)
head(id.map.cas)
head(cpd.kc)

#map KEGG ID to compound name
cpd.names=cpdkegg2name(in.ids=id.map.cas[,2])
head(cpd.names)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
