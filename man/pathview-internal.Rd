\name{pathview-internal}

\alias{KEGGEdgeSubtype}
\alias{parseReaction2}
\alias{subtypeDisplay.kedge}
\alias{KEGGpathway2Graph2}
\alias{parseKGML2.R}
\alias{parseKGML2Graph2}
\alias{max.abs}
\alias{random}
\alias{kegg.legend}
\alias{pathview.stamp}
\alias{circles}
\alias{ellipses}
\alias{sliced.shapes}
\alias{colorpanel2}

\title{Internal functions}
\description{
  Not intended to be called by the users.
}
\details{
  These functions are not to be called by the user directly.

  Functions parseReaction2, parseKGML2,  KEGGpathway2Graph2 and
  parseKGML2Graph2 parse KEGG pathways
  from KGML files. Function subtypeDisplay.kedge and data
  KEGGEdgeSubtype extact and store edge subtypes and corresponding
  rendering information. All these functions/data were modified from the
  original copies in KEGGgraph package.

  Function kegg.legend generates legend for KEGG edge and node
  types. Function pathview.stamp generates pathview sisgnature on graphs.
  
  Function colorpanel2 comes from gplots package function colorpanel.
  
  Functions max.abs and random among others are method to summarize data
  at molecular level or node level when multiple items mapping to the
  same ID/node. 

  Function circles, ellipses and sliced.shapes draw KEGG nodes in colored shapes
  (circles and ellipses).
  
  Functions deComp and rownorm were written by Weijun Luo, the author of
  gage package.
}
\keyword{ internal }
