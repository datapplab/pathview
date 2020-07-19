\name{combineKEGGnodes}
\alias{combineKEGGnodes}
\alias{reaction2edge}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Special treatment of nodes or edges for KEGG pathway rendering
}
\description{
  \code{combineKEGGnodes} combines nodes into a group in a KEGG pathway
  graph. 
  \code{reaction2edge} converts reactions into edges in KEGG pathway
  graph.
}
\usage{
combineKEGGnodes(nodes, graph, combo.node)
reaction2edge(path, gR)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{nodes}{
character, names of the names to be combined.
}
  \item{graph, gR}{
a object of "graphNEL" class, the graph parsed and converted from KEGG
pathway.
}
  \item{path}{
a object of "KEGGPathway" class, the parsed  KEGG pathway.
}
  \item{combo.node}{
character, the name of result combined node.
}
}
\details{
  \code{combineKEGGnodes} not only combines nodes in the graph object,
  but also corresponding node data in the KEGG pathway object. This
  function is needed for KEGG-defined group nodes and parsed enzyme
  groups involved in the same reaction.
  \code{reaction2edge} converts a reaction into 2 consecutive edges
  between substrate and enzyme and enzyme and product. This function is
  needed as to faithfully show the compound-enzyme nodes and their
  interactions in Graphviz-style view of KEGG pathway.
}
\value{
    The results returned by \code{combineKEGGnodes} is a combined graph
    of "graphNEL" class.
  The results returned by \code{reaction2edge} is a list of 3
  elements: \code{gR}, the converted graph ("graphNEL"); edata.new, the
  new edge data ("KEGGEdge"); ndata.new, the new node data ("KEGGNode").
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
  \code{\link{node.info}} the main parser function
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
