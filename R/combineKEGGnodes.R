combineKEGGnodes <-
function (nodes, graph, combo.node)
  {
    nodes=unique(nodes)
    nodes.all=nodes(graph)
    ii=nodes %in% nodes.all
    if(!all(ii)){
      anodes=nodes[!ii]
      stop(paste("Nodes ", paste(anodes, collapse=", "), " are not part of the graph!", sep=""))
    }



    knode=getKEGGnodeData(graph)
    kedge=getKEGGedgeData(graph)
    nodeNames=sapply(knode, getName)
    nodeType=sapply(knode, getType)
    nodeComp=sapply(knode, getComponent)
    node.size=sapply(nodeComp, length)
    grp.nodes=nodes.all[node.size>1]

    nt=unique(nodeType[nodes])
    len.nt=length(nt)
    if("ortholog" %in% nt) len.nt=len.nt-1
    if(len.nt>1) {
      warn.msg="Nodes are not the same type, hence unable to combine!"
      message("Warning: ", warn.msg)
      return(graph)
    }
    
    if(combo.node %in% grp.nodes){

      combgraph <- combineNodes(c(nodes,combo.node), graph, combo.node)
      gnode=knode[[combo.node]]
      ng.component= unique(c(gnode@component, nodes))
      ng.graphics= gnode@graphics
      ng.graphics@height=as.integer(length(ng.component)/length(gnode@component)*ng.graphics@height)
    } else{
      if(combo.node %in% nodes.all){
        combgraph <- combineNodes(c(nodes,combo.node), graph, combo.node)
        ng.component= unique(c(combo.node, nodes))
        ng.graphics= knode[[combo.node]]@graphics
        ng.graphics@height=as.integer(length(ng.component)*ng.graphics@height)
      } else{
        combgraph <- combineNodes(nodes, graph, combo.node)
        ng.component= unique(nodes)
        ng.graphics= knode[[nodes[1]]]@graphics
        ng.graphics@height=as.integer(length(ng.component)*ng.graphics@height)
      }
    }

    ng.entryID= combo.node
    ng.name= "undefined"
    ng.type= "group"
    ng.link= as.character(NA)
    ng.reaction= as.character(NA)
    ng.map= as.character(NA)
    new.gnode <- new("KEGGGroup", component = ng.component, entryID = ng.entryID,
                     name = ng.name, type = ng.type, link = ng.link, reaction = ng.reaction,
                     map = ng.map, graphics = ng.graphics)

    knode.new=knode[!nodes.all %in% nodes]
    knode.new[[combo.node]]=new.gnode

    kedge.new=kedge
    enames=names(kedge)
    eeids=sapply(strsplit(enames, "~"), function(x) x)
    idx1=eeids[1,] %in% nodes
    idx2=eeids[2,] %in% nodes
    idx=idx1 | idx2
    for(i in which(idx1)) kedge.new[[i]]@entry1ID=eeids[1,i]=combo.node
    for(i in which(idx2)) kedge.new[[i]]@entry2ID=eeids[2,i]=combo.node
    names(kedge.new)[idx]=paste(eeids[1,idx],eeids[2,idx], sep = "~")
    
    env.node <- new.env()
    env.edge <- new.env()
    assign("nodes", knode.new, envir = env.node)
    assign("edges", kedge.new, envir = env.edge)
    nodeDataDefaults(combgraph, "KEGGNode") <- env.node
    edgeDataDefaults(combgraph, "KEGGEdge") <- env.edge
    return(combgraph)
  }

