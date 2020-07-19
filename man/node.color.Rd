\name{node.color}
\alias{node.color}
\alias{col.key}

\title{
Code molecular data as pseudo colors on the pathway graph
}
\description{


\code{node.color} converts the mapped molecular (gene, protein
or metabolite etc) data as pseudo colors on pathway nodes.
\code{col.key} draws color key(s) for mapped molecular data on the
pathway graph.
}
\usage{
node.color(plot.data = NULL, discrete=FALSE, limit, bins, both.dirs =
TRUE, low = "green", mid = "gray", high = "red", na.col = "transparent",
trans.fun = NULL)
col.key(discrete=FALSE, limit = 1, bins = 10, cols = NULL, both.dirs =
TRUE, low = "green", mid = "gray", high = "red", graph.size, node.size,
size.by.graph = TRUE, key.pos = "topright", off.sets = c(x = 0, y = 0),
align = "n", cex = 1, lwd = 1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{plot.data}{
  the result returned by \code{node.map} function. It is a data.frame composed
  of parsed KGML data and summary molecular data
  for each mapped node. Rows are mapped nodes, and columns are
  parsed or mapped node data. Check \code{node.map} for details.
}
  \item{discrete}{
logical, whether to treat the molecular data or node summary data as discrete. d
  discrete=FALSE, otherwise, mol.data will be a charactor vector of
  molecular IDs.
}
  \item{limit}{
a list of two numeric elements with "gene" and "cpd" as the names. This
argument specifies the limit values for gene.data and cpd.data when converting
them to pseudo colors. Each element of the list could be of length 1 or
2. Length 1 suggests discrete data or 1 directional (positive-valued)
data, or the absolute limit for 2 directional data. Length 2 suggests 2
directional data. Default limit=list(gene=0.5, cpd=1).
}
  \item{bins}{
a list of two integer elements with "gene" and "cpd" as the names. This
argument specifies the number of levels or bins for gene.data and cpd.data when converting
them to pseudo colors. Default limit=list(gene=10, cpd=10).
}
  \item{both.dirs}{
a list of two logical  elements with "gene" and "cpd" as the names. This
argument specifies whether gene.data and cpd.data are 1 directional or 2
directional data when converting them to pseudo colors. Default limit=list(gene=TRUE, cpd=TRUE).
}
  \item{trans.fun}{
a list of two function (not character) elements with "gene" and "cpd" as the names. This
argument specifies whether and how gene.data and cpd.data are
transformed. Examples are \code{log}, \code{abs} or users' own
functions. Default limit=list( gene=NULL, cpd=NULL).
}
  \item{low, mid, high}{
each is a list of two colors with "gene" and "cpd" as the names. This
argument specifies the color spectra to code gene.data and
cpd.data. When data are 1 directional (TRUE value in both.dirs), only
mid and high are used to specify the color spectra. Default spectra (low-mid-high)
"green"-"gray"-"red" and "blue"-"gray"-"yellow" are used for gene.data
and cpd.data respectively. 
The values for 'low, mid, high' can be given as color names
('red'), plot color index (2=red), and HTML-style RGB,
("\#FF0000"=red).
}
  \item{na.col}{
color used for NA's or missing values in gene.data and cpd.data. d
na.col="transparent". 
}

  \item{cols}{
character, specifying a discrete spectrum of colors to be plotted as
color key. Note this argument is usually NULL (default), otherwise, the
number of discrete colors has to match \code{bins}.
}
  \item{graph.size}{
numeric vector of length 2, i.e. the sizes (width, height) of the
pathway graph panel. This is needed to determine the sizes and exact
location of the color key. 
}
  \item{node.size}{
numeric vector of length 2, i.e. the sizes (width, height) of the
standard gene nodes (rectangles). This is needed to determine the sizes
and exact location of the color key when size.by.graph=FALSE. 
}
  \item{size.by.graph}{
logical, whether to determine the sizes and exact location of the color
key with respect to the size of the whole graph panel or that of a
single node. Default size.by.graph=TRUE. 
}
  \item{key.pos}{
character, controlling the position of color key(s). Potentail values
  are "bottomleft", "bottomright", "topleft" and "topright". d
  key.pos="topright". 
}
  \item{off.sets}{
numeric vector of length 2, with "x" and "y" as the names. This argument
specifies the offset values in x and y axes when plotting a new color
key, as to avoid overlap with existing color keys or boundaries. Note
that the \code{off.sets} value is reset and returned each time
\code{col.key} function is called, as for the reference of plotting the
next color key. Default off.sets=c(0,0).
}
  \item{align}{
character, controlling how the color keys are aligned when
needed. Potential values are "x", aligned by x coordinates, and "y",
aligned by y coordinates. Default align="x". 
}
  \item{cex}{
    A numerical value giving the amount by which legend text
    and symbols should be scaled relative to the default 1. 
}
  \item{lwd}{
 numeric, the line width, a _positive_ number, defaulting to '1'. 
}
}
\details{
\code{node.color} converts the mapped molecular data (gene.data or cpd.data) by
node.map function into pseudo colors, which then can be plotted on the
pathway graph.
\code{col.key} is used in combination with node.color in pathview, although
this function can be used independently for similar tasks.
}
\value{
\code{node.color} returns a vector or matrix of colors. Its
dimensionality is the same as the corresponding gene.data or cpd.data.
\code{col.key} plots a color key on existing pathway graph, then returns
a updated version of off.sets for the reference of next color key.
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
  \code{\link{keggview.native}} and \code{\link{keggview.graph}} the
  viwer functions,
  \code{\link{node.map}} the node data mapper function.
}
\examples{
xml.file=system.file("extdata", "hsa04110.xml", package = "pathview")
node.data=node.info(xml.file)
names(node.data)
data(gse16873.d)
plot.data.gene=node.map(mol.data=gse16873.d[,1], node.data,
  node.types="gene")
head(plot.data.gene)
cols.ts.gene=node.color(plot.data.gene, limit=1, bins=10)
head(cols.ts.gene)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
