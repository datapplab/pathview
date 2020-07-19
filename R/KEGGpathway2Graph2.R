KEGGpathway2Graph2 <-
function (pathway, genesOnly = TRUE, expandGenes = TRUE, split.group=FALSE, check.reaction=TRUE)
  {
    stopifnot(is(pathway, "KEGGPathway"))
    if(split.group) pathway <- splitKEGGgroup(pathway)
    rdata=(pathway@reactions)
    if (expandGenes){
      if(check.reaction & length(rdata)>0) message("Note: ", "Gene nodes not expanded when reactions are converted to edges!")
      else pathway <- expandKEGGPathway(pathway)
    }
    knodes <- nodes(pathway)
    kedges <- edges(pathway)
    node.entryIDs <- getEntryID(knodes)
    edge.entryIDs <- getEntryID(kedges)
    V <- node.entryIDs
    edL <- vector("list", length = length(V))
    names(edL) <- V
    if (is.null(nrow(edge.entryIDs))) {
      for (i in seq(along = edL)) {
        edL[[i]] <- list()
      }
    }
    else {
      for (i in 1:length(V)) {
        id <- node.entryIDs[i]
        hasRelation <- id == edge.entryIDs[, "Entry1ID"]
        if (!any(hasRelation)) {
          edL[[i]] <- list(edges = NULL)
        }
        else {
          entry2 <- unname(unique(edge.entryIDs[hasRelation,
                                                "Entry2ID"]))
          edL[[i]] <- list(edges = entry2)
        }
      }
    }
    gR <- new("graphNEL", nodes = V, edgeL = edL, edgemode = "directed")

    if(check.reaction & length(rdata)>0){
      r2e.res=reaction2edge(pathway, gR)
      gR=r2e.res[[1]]
      kedges=r2e.res[[2]]
      knodes=r2e.res[[3]]
    }

    names(kedges) <- sapply(kedges, function(x) paste(getEntryID(x),
                                                      collapse = "~"))
    env.node <- new.env()
    env.edge <- new.env()
    assign("nodes", knodes, envir = env.node)
    assign("edges", kedges, envir = env.edge)
    nodeDataDefaults(gR, "KEGGNode") <- env.node
    edgeDataDefaults(gR, "KEGGEdge") <- env.edge
    if (genesOnly) {
      gR <- subGraphByNodeType(gR, "gene")
    }
    return(gR)
  }
