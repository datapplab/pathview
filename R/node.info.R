node.info <-
function(object, short.name=TRUE){
  cobj=class(object)[1]
  if(cobj=="character"){
    object <-parseKGML2(object)
    ndata=nodes(object)    
  } else if(cobj=="KEGGPathway"){
    ndata=nodes(object)
  } else  if(cobj=="graphNEL"){
    ndata=getKEGGnodeData(object)
  }  else {
    stop("object should be either a filename, KEGGPathway, or graphNEL!")
  }

  nodeNames=sapply(ndata, getName)
  nodeType=sapply(ndata, getType)
  nodeComp=sapply(ndata, getComponent)
  node.size=sapply(nodeComp, length)

  grs1=sapply(ndata, function(x){
    grs=x@graphics
    c(labels=grs@name, shape=grs@type)
  })
  grs2=sapply(ndata, function(x){
    grs=x@graphics
    c(x=grs@x,y=grs@y,width=grs@width,height=grs@height)
  })
  grs1=t(grs1)
  grs2=t(grs2)

  graphic.data=as.list(cbind(data.frame(grs1, stringsAsFactors=F), data.frame(grs2)))
  nd.list=list(kegg.names=nodeNames, type=nodeType, component=nodeComp, size=node.size)
  nd.list=c(nd.list, graphic.data)
  if(short.name){
    gnames=sapply(strsplit(nd.list$labels, ", "), "[[", 1)
    map.idx=nd.list$type=="map"
    gnames[map.idx]=nd.list$labels[map.idx]
    gnames[is.na(gnames)]=""
    gnames=gsub("[.][.][.]", "", gnames)
    nd.list$labels=gnames
    nd.list$kegg.names=lapply(nd.list$kegg.names, function(x) gsub("^.*:", "", x))
  }
  
  nn=names(nodeNames)
  nd.list= lapply(nd.list, function(x) {
    names(x) <- nn
    return(x)
  })
  return(nd.list)
}

