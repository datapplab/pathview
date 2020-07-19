\name{pathview}
\alias{pathview}
\alias{keggview.native}
\alias{keggview.graph}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Pathway based data integration and visualization
}
\description{
Pathview is a tool set for pathway based data integration and
visualization. It maps and renders user data on relevant pathway
graphs. All users need is to supply their gene or compound data and
specify the target pathway. Pathview automatically downloads the pathway
graph data, parses the data file, maps user data to the pathway, and
render pathway graph with the mapped data.
Pathview generates both native KEGG view and Graphviz views for
pathways. keggview.native and keggview.graph are the two viewer
functions, and pathview is the main function providing a unified
interface to downloader, parser, mapper and viewer functions.
}
\usage{
pathview(gene.data = NULL, cpd.data = NULL, pathway.id,
species = "hsa", kegg.dir = ".", cpd.idtype = "kegg", gene.idtype =
"entrez", gene.annotpkg = NULL, min.nnodes = 3, kegg.native = TRUE,
map.null = TRUE, expand.node = FALSE, split.group = FALSE, map.symbol =
TRUE, map.cpdname = TRUE, node.sum = "sum", discrete=list(gene=FALSE,
cpd=FALSE), limit = list(gene = 1, cpd = 1), bins = list(gene = 10, cpd
= 10), both.dirs = list(gene = T, cpd = T), trans.fun = list(gene =
NULL, cpd = NULL), low = list(gene = "green", cpd = "blue"), mid =
list(gene = "gray", cpd = "gray"), high = list(gene = "red", cpd =
"yellow"), na.col = "transparent", ...)

keggview.native(plot.data.gene = NULL, plot.data.cpd = NULL,
cols.ts.gene = NULL, cols.ts.cpd = NULL, node.data, pathway.name,
out.suffix = "pathview", kegg.dir = ".", multi.state=TRUE, match.data =
TRUE, same.layer = TRUE, res = 300, cex = 0.25, discrete =
list(gene=FALSE, cpd=FALSE), limit= list(gene = 1, cpd = 1), bins =
list(gene = 10, cpd = 10), both.dirs =list(gene = T, cpd = T), low =
list(gene = "green", cpd = "blue"), mid = list(gene = "gray", cpd =
"gray"), high = list(gene = "red", cpd = "yellow"), na.col =
"transparent", new.signature = TRUE, plot.col.key = TRUE, key.align =
"x", key.pos = "topright", ...)

keggview.graph(plot.data.gene = NULL, plot.data.cpd = NULL, cols.ts.gene
= NULL, cols.ts.cpd = NULL, node.data, path.graph, pathway.name,
out.suffix = "pathview", pdf.size = c(7, 7), multi.state=TRUE,
same.layer = TRUE, match.data = TRUE, rankdir = c("LR", "TB")[1],
is.signal = TRUE, split.group = F, afactor = 1, text.width = 15, cex =
0.5, map.cpdname = FALSE, cpd.lab.offset = 1.0,
discrete=list(gene=FALSE, cpd=FALSE), limit = list(gene = 1, cpd = 1),
bins = list(gene = 10, cpd = 10), both.dirs = list(gene = T, cpd = T),
low = list(gene = "green", cpd = "blue"), mid = list(gene = "gray", cpd
= "gray"), high = list(gene = "red", cpd = "yellow"), na.col =
"transparent", new.signature = TRUE, plot.col.key = TRUE, key.align =
"x", key.pos = "topright", sign.pos = "bottomright", ...)  }

\arguments{
  \item{gene.data}{
  either vector (single sample) or a matrix-like data (multiple
  sample). Vector should be numeric with gene IDs as names or it may
  also be character of gene IDs. Character vector is treated as discrete
  or count data. Matrix-like data structure has genes as rows and
  samples as columns. Row names should be gene IDs. Here gene ID is a
  generic concepts, including multiple types of gene, transcript and
  protein uniquely mappable to KEGG gene IDs. KEGG ortholog IDs are also
  treated as gene IDs as to handle metagenomic data. Check details for
  mappable ID types. Default gene.data=NULL.

  numeric, character, continuous
}
  \item{cpd.data}{
 the same as gene.data, excpet named with IDs mappable to KEGG
 compound IDs. Over 20 types of IDs included in CHEMBL database can be
 used here. Check details for mappable ID types. Default
 cpd.data=NULL. Note that gene.data and cpd.data can't be NULL
 simultaneously.
}
  \item{pathway.id}{
 character vector, the KEGG pathway ID(s), usually 5 digit, may also include the 3
 letter KEGG species code.
}
  \item{species}{
character, either the kegg code, scientific name or the common name of
the target species. This applies to both pathway and gene.data or
cpd.data. When KEGG ortholog pathway is considered,
species="ko". Default species="hsa", it is equivalent to use either
"Homo sapiens" (scientific name) or "human" (common name). 
}
  \item{kegg.dir}{
character, the directory of KEGG pathway data file (.xml) and image file
(.png). Users may supply their own data files in the same format and
naming convention of KEGG's (species code + pathway id,
e.g. hsa04110.xml, hsa04110.png etc) in this directory. Default
kegg.dir="." (current working directory). 
}
  \item{cpd.idtype}{
character, ID type used for the cpd.data. Default cpd.idtype="kegg" (include
compound, glycan and drug accessions). 
}
  \item{gene.idtype}{
character, ID type used for the gene.data, case insensitive. Default
gene.idtype="entrez", i.e. Entrez Gene, which are the primary KEGG gene ID
for many common model organisms. For other species, gene.idtype should
be set to "KEGG" as KEGG use other types of gene IDs. For the common
model organisms (to check the list, do: \code{data(bods); bods}), you
may also specify other types of valid IDs. To check the ID list, do:
\code{data(gene.idtype.list); gene.idtype.list}. 
}
  \item{gene.annotpkg}{
character, the name of the annotation package to use for mapping between
other gene ID types including symbols and Entrez gene ID. Default gene.annotpkg=NULL.
}
  \item{min.nnodes}{
integer, minimal number of nodes of type "gene","enzyme", "compound" or
"ortholog" for a pathway to be considered. Default min.nnodes=3.
}
  \item{kegg.native}{
logical, whether to render pathway graph as native KEGG graph (.png) or
using graphviz layout engine (.pdf). Default kegg.native=TRUE.
}
  \item{map.null}{
logical, whether to map the NULL gene.data or cpd.data to pathway. When
NULL data are mapped, the gene or compound nodes in the pathway will be
rendered as actually mapped nodes, except with NA-valued color. When
NULL data are not mapped, the nodes are rendered as unmapped nodes. This
argument mainly affects native KEGG graph view, i.e. when
kegg.native=TRUE. Default map.null=TRUE.
}
  \item{expand.node}{
logical, whether the multiple-gene nodes are expanded into single-gene
nodes. Each expanded single-gene nodes inherits all edges from the
original multiple-gene node. This option only affects graphviz graph view, i.e. when
kegg.native=FALSE. This option is not effective for most metabolic
pathways where it conflits with  converting reactions to edges. Default expand.node=FLASE.
}
  \item{split.group}{
logical, whether split node groups are split to individual nodes. Each
split member nodes inherits all edges from the node group. This
option only affects graphviz graph view, i.e. when
kegg.native=FALSE. This option also effects most metabolic
pathways even without group nodes defined orginally. For these pathways,
genes involved in the same reaction are grouped automatically when
converting reactions to edges unless split.group=TRUE. d
split.group=FLASE.
}
  \item{map.symbol}{
logical, whether map gene IDs to symbols for gene node labels or use the
graphic name from the KGML file. This option is only effective for
kegg.native=FALSE or same.layer=FALSE when kegg.native=TRUE. For
same.layer=TRUE when kegg.native=TRUE, the native KEGG labels will be
kept. Default map.symbol=TRUE.
}
  \item{map.cpdname}{
logical, whether map compound IDs to formal names for compound node labels or use the
graphic name from the KGML file (KEGG compound accessions). This option is only effective for
kegg.native=FALSE. When kegg.native=TRUE, the native KEGG labels will be
kept. Default map.cpdname=TRUE.
}
  \item{node.sum}{
  character, the method name to calculate node summary given that
  multiple genes or compounds are mapped to it. Poential options include
  "sum","mean", "median", "max", "max.abs" and "random". Default node.sum="sum".
}
  \item{discrete}{
a list of two logical elements with "gene" and "cpd" as the names. This
argument tells whether gene.data or cpd.data should be treated as
discrete. Default dsicrete=list(gene=FALSE, cpd=FALSE), i.e. both data should
be treated as continuous.
}
  \item{limit}{
a list of two numeric elements with "gene" and "cpd" as the names. This
argument specifies the limit values for gene.data and cpd.data when converting
them to pseudo colors. Each element of the list could be of length 1 or
2. Length 1 suggests discrete data or 1 directional (positive-valued)
data, or the absolute limit for 2 directional data. Length 2 suggests 2
directional data. Default limit=list(gene=1, cpd=1).
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
functions. Default limit=list(gene=NULL, cpd=NULL).
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
  \item{\dots}{
extra arguments passed to keggview.native or keggview.graph function.
}

special arguments for keggview.native or keggview.graph function.
  \item{plot.data.gene}{
data.frame returned by node.map function for rendering mapped gene
  nodes, including node name, type, positions (x, y), sizes (width,
  height), and mapped gene.data. This data is also used as input for
  pseduo-color coding through node.color function. Default plot.data.gene=NULL.
}
  \item{plot.data.cpd}{
same as plot.data.gene function, except for mapped compound node data. d
  plot.data.cpd=NULL. Default plot.data.cpd=NULL. Note that plot.data.gene and
  plot.data.cpd can't be NULL simultaneously.
}
  \item{cols.ts.gene}{
vector or matrix of colors returned by node.color function for rendering
  gene.data. Dimensionality is the same as the latter. Default cols.ts.gene=NULL.
}
  \item{cols.ts.cpd}{
same as cols.ts.gene, except corresponding to cpd.data. d
  cols.ts.cpd=NULL. Note that cols.ts.gene and cols.ts.cpd
  plot.data.gene can't be NULL simultaneously. 
}
  \item{node.data}{
list returned by node.info function, which parse KGML file directly or
  indirectly, and extract the node data.
}
  \item{pathway.name}{
character, the full KEGG pathway name in the format of 3-letter species
  code with 5-digit pathway id, eg "hsa04612". 
}
  \item{out.suffix}{
character, the suffix to be added after the pathway name as part of the
  output graph file. Sample names or column names of the gene.data or
  cpd.data are also added when there are multiple samples. Default out.suffix="pathview".
}
\item{multi.state}{
  logical, whether multiple states (samples or columns) gene.data or
  cpd.data should be integrated and plotted in the same graph. Default
  match.data=TRUE. In other words, gene or compound nodes will be sliced
  into multiple pieces corresponding to the number of states in the
  data.
}
  \item{match.data}{
  logical, whether the samples of gene.data and cpd.data are
  paired. Default match.data=TRUE. When let sample sizes of gene.data
  and cpd.data be m and n, when m>n, extra columns of NA's (mapped to no
  color) will be added to cpd.data as to make the sample size the
  same. This will result in the smae number of slice in gene nodes and
  compound when multi.state=TRUE.
}
  \item{same.layer}{
    logical, control plotting layers:
    1) if node colors be plotted in the same layer as the pathway
  graph when kegg.native=TRUE, 2) if  edge/node type legend be plotted in
  the same page when kegg.native=FALSE.
}
  \item{res}{
    The nominal resolution in ppi which will be recorded in the
    bitmap file, if a positive integer.  Also used for 'units'
    other than the default, and to convert points to pixels. This
  argument is only effective when kegg.native=TRUE. Default res=300.
}
  \item{cex}{
    A numerical value giving the amount by which plotting text
    and symbols should be scaled relative to the default 1. Default cex=0.25
  when kegg.native=TRUE, cex=0.5 when kegg.native=FALSE.
}
  \item{new.signature}{
    logical, whether pathview signature is added to the pathway
  graphs. Default new.signature=TRUE.
}
  \item{plot.col.key}{
    logical, whether color key is added to the pathway
  graphs. Default plot.col.key= TRUE.

}
  \item{key.align}{
character, controlling how the color keys are aligned when both
  gene.data and cpd.data are not NULL. Potential values are "x", aligned
  by x coordinates, and "y", aligned by y coordinates. Default key.align="x".
}
  \item{key.pos}{
character, controlling the position of color key(s). Potentail values
  are "bottomleft", "bottomright", "topleft" and "topright". d
  key.pos="topright". 
}
  \item{sign.pos}{
character, controlling the position of pathview signature. Only
  effective when kegg.native=FALSE, Signature position is fixed in place
  of the original KEGG signature when kegg.native=TRUE. Potentail values
  are "bottomleft", "bottomright", "topleft" and "topright". d
  sign.pos="bottomright". 
}

  \item{path.graph}{
a graph object parsed from KGML file, only effective when
kegg.native=FALSE.
}
  \item{pdf.size}{
a numeric vector of length 2, giving the width and height of the pathway
graph pdf file. Note that pdf width increase by half when
same.layer=TRUE to accommodate legends. Only effective when
kegg.native=FALSE. Default pdf.size=c(7,7).
}
  \item{rankdir}{
character, either "LR" (left to right) or "TB" (top to bottom),
specifying the pathway graph layout direction. Only effective when
kegg.native=FALSE. Default rank.dir="LR".
}
  \item{is.signal}{
logical, if the pathway is treated as a signaling pathway, where all the
unconnected nodes are dropped. This argument also affect the graph
layout type, i.e. "dot" for signals or "neato" otherwise. Only effective when
kegg.native=FALSE. Default is.signal=TRUE.
}
  \item{afactor}{
numeric, node amplifying factor. This argument is for node size
fine-tuning, its effect is subtler than expected. Only effective when
kegg.native=FALSE. Default afctor=1.
}
  \item{text.width}{
numeric, specifying the line width for text wrap. Only effective when
kegg.native= FALSE. Default text.width=15 (characters).
}
  \item{cpd.lab.offset}{
numeric, specifying how much compound labels should be put above the
default position or node center. This argument is useful when
map.cpdname=TRUE, i.e. compounds are labelled by full name, which
affects the look of compound nodes and color. Only effective when
kegg.native=FALSE. Default cpd.lab.offset=1.0.
}
}
\details{
Pathview maps and renders user data on relevant pathway graphs. Pathview
is a stand alone program for pathway based data integration and
visualization. It also seamlessly integrates with pathway and functional
analysis tools for large-scale and fully automated analysis.
Pathview provides strong support for data Integration. It works with: 1)
essentially all types of biological data mappable to pathways, 2) over
10 types of gene or protein IDs, and 20 types of compound or metabolite
IDs, 3) pathways for over 2000 species as well as KEGG orthology, 4)
varoius data attributes and formats, i.e. continuous/discrete data,
matrices/vectors, single/multiple samples etc.
To see mappable external gene/protein IDs do:
\code{data(gene.idtype.list)}, to see mappable external compound related
IDs do: \code{data(rn.list)}; names(rn.list).
Pathview generates both native KEGG view and Graphviz views for
pathways. Currently only KEGG pathways are implemented. Hopefully, pathways from
Reactome, NCI and other databases will be supported in the future.
}
\value{
  From viersion 1.9.3, pathview can accept either a single pathway or
  multiple pathway ids. The result returned by pathview function is a
  named list corresponding to the input pathway ids. Each element (for
  each pathway itself is a named list, with 2
  elements ("plot.data.gene", "plot.data.cpd"). Both elements
  are data.frame or NULL depends on the corresponding input
  data gene.data and cpd.data. These data.frames record the plot data
  for mapped gene or compound nodes: rows are mapped genes/compounds,
  columns are:
  \item{kegg.names}{standard KEGG IDs/Names for mapped nodes. It's
    Entrez Gene ID or KEGG Compound Accessions.}
  \item{labels}{Node labels to be used when needed.
  }
  \item{all.mapped}{All molecule (gene or compound) IDs mapped to this
    node.
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
  \item{other columns }{columns of the mapped gene/compound data and
    corresponding pseudo-color codes for individual samples
  }      

    The results returned by \code{keggview.native} and
  code{keggview.graph} are both a list of graph plotting
  parameters. These are not intended to be used externally.

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
  \code{\link{download.kegg}} the downloader,
  \code{\link{node.info}} the parser,
  \code{\link{node.map}} and \code{\link{node.color}} the mapper. 
}

\examples{
#load data
data(gse16873.d)
data(demo.paths)

#KEGG view: gene data only
i <- 1
pv.out <- pathview(gene.data = gse16873.d[, 1], pathway.id =
demo.paths$sel.paths[i], species = "hsa", out.suffix = "gse16873",
kegg.native = TRUE)
str(pv.out)
head(pv.out$plot.data.gene)
#result PNG file in current directory

#Graphviz view: gene data only
pv.out <- pathview(gene.data = gse16873.d[, 1], pathway.id =
demo.paths$sel.paths[i], species = "hsa", out.suffix = "gse16873",
kegg.native = FALSE, sign.pos = demo.paths$spos[i])
#result PDF file in current directory

#KEGG view: both gene and compound data
sim.cpd.data=sim.mol.data(mol.type="cpd", nmol=3000)
i <- 3
print(demo.paths$sel.paths[i])
pv.out <- pathview(gene.data = gse16873.d[, 1], cpd.data = sim.cpd.data,
pathway.id = demo.paths$sel.paths[i], species = "hsa", out.suffix =
"gse16873.cpd", keys.align = "y", kegg.native = TRUE, key.pos = demo.paths$kpos1[i])
str(pv.out)
head(pv.out$plot.data.cpd)

#multiple states in one graph
set.seed(10)
sim.cpd.data2 = matrix(sample(sim.cpd.data, 18000, 
    replace = TRUE), ncol = 6)
pv.out <- pathview(gene.data = gse16873.d[, 1:3], 
    cpd.data = sim.cpd.data2[, 1:2], pathway.id = demo.paths$sel.paths[i], 
    species = "hsa", out.suffix = "gse16873.cpd.3-2s", keys.align = "y", 
    kegg.native = TRUE, match.data = FALSE, multi.state = TRUE, same.layer = TRUE)
str(pv.out)
head(pv.out$plot.data.cpd)

#result PNG file in current directory

##more examples of pathview usages are shown in the vignette.
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
