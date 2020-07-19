\name{node.info}
\alias{node.info}

\title{
  Extract node information from KEGG pathway
}
\description{
  The parser function, parser KGML file and/or extract node information
  from KEGG pathway. 
}
\usage{
node.info(object, short.name = TRUE)
}

\arguments{
  \item{object}{
either a character specifying the full KGML file name (with directory),
  or a object of "KEGGPathway" class, or a object of "graphNEL"
  class. The latter two are parsed results of KGML file.
}
  \item{short.name}{
logical, if TRUE, the short labels, i.e. the first iterm separated by
  "," in the long labels are parsed out as node labels. Default short.name=TRUE.
}
}
\details{
Parser function node.info extract node data from parsed KEGG
  pathways. KGML files are parsed using \code{parseKGML2} and
  \code{KEGGpathway2Graph2}. These functions from KEGGgraph package have
  been heavily modified for reaction parsing and conversion to
  edges.
}
\value{
a named list of 10 elements: "kegg.names", "type", "component", "size",
"labels", "shape", "x", "y", "width" and "height". Each elements record
  the corresponding attribute for all nodes in the parsed KEGG pathway.
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
  \code{\link{pathview}} the main function,
  \code{\link{combineKEGGnodes}} and \code{\link{reaction2edge}} for
  special treatment of nodes or edges.
}
\examples{
xml.file=system.file("extdata", "hsa04110.xml", package = "pathview")
node.data=node.info(xml.file)
names(node.data)
#or parse into a graph object, then extract node info
gR1=pathview:::parseKGML2Graph2(xml.file, genesOnly=FALSE, expand=FALSE, split.group=FALSE)
node.data=node.info(gR1)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
