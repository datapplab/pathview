parseKGML2<-function (file)
  {
    doc <- xmlTreeParse(file, getDTD = FALSE)
    r <- xmlRoot(doc)
    childnames <- sapply(xmlChildren(r), xmlName)
    isEntry <- childnames == "entry"
    isRelation <- childnames == "relation"
    isReaction <- childnames == "reaction"
    kegg.pathwayinfo <- parsePathwayInfo(r)
    kegg.nodes <- sapply(r[isEntry], parseEntry)
    kegg.edges <- sapply(r[isRelation], parseRelation)
    kegg.reactions <- sapply(r[isReaction], parseReaction2)
    names(kegg.nodes) <- sapply(kegg.nodes, getEntryID)
    pathway <- new("KEGGPathway", pathwayInfo = kegg.pathwayinfo,
                   nodes = kegg.nodes, edges = kegg.edges, reactions = kegg.reactions)
    return(pathway)
  }
