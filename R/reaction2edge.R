reaction2edge <-
function(path, gR){
  
#  gR=kegg2graph(path,genes=F,expand=F, split.group=F)
  ndata=nodes(path)
  rdata=(path@reactions)
  edata=edges(path)
  if(length(ndata)<2 | length(rdata)<1){
  message("Note: ", "Pathway has no reaction, no conversion needed!")
  return(list(gR, edata, ndata))
  }
  
  snames=slotNames(rdata[[1]])
  rdata.tab=sapply(rdata, function(x){
    sapply(snames, function(sn) slot(x, sn))#x@sn not work
  })
  rdata.tab=t(rdata.tab)

  snames2=slotNames(ndata[[1]])[c(1,2,3,5)]
  ndata.tab=sapply(ndata, function(x){
    sapply(snames2, function(sn) paste(slot(x, sn), collapse=","))#x@sn not work
  })
  ndata.tab=t(ndata.tab)
  rn.tab=ndata.tab[,"reaction"]!="NA"
  rn.tab=ndata.tab[rn.tab,]

  len.ed=length(edata)
  if(len.ed>0){
    snames3=slotNames(edata[[1]])
    edata.tab=sapply(edata, function(x){
      idtype=sapply(snames3[1:3], function(sn) slot(x, sn))#x@sn not work
      stnames=paste(sapply(x@subtype, function(y) y@name), collapse=",")
      stvals=paste(sapply(x@subtype, function(y) y@value), collapse=",")
      return(c(idtype, subtype.name=stnames,subtype.value=stvals))
    })
    edata.tab=t(edata.tab)
  }

#new node.data
  rn.grps=split(rn.tab[,"entryID"], rn.tab[,"reaction"])
  rn.len=sapply(rn.grps, length)
  grp.idx=which(rn.len>1)
#  grp nodes only for reactions with >1 genes
  eid=max(as.numeric(names(ndata)))+1:length(grp.idx)
  eid=as.character(eid)
  rnames=names(rn.grps)
  ndata.new=list()
  if(length(grp.idx)>0){
  for(i in 1:length(grp.idx)){
    j=grp.idx[i]
    ndata1=ndata[[rn.grps[[j]][1]]]
    gdata1=ndata1@graphics
    h1=gdata1@height*rn.len[j]
    gdata.new=new("KEGGGraphics",name=NA_character_, fgcolor="#000000", bgcolor="#FFFFFF", type="rectangle",
      x=gdata1@x, y=gdata1@y, width=gdata1@width, height=h1)
    ndata.new[[i]]<- new("KEGGGroup", component = rn.grps[[j]], entryID = eid[i],
                         name="undefined", type="group", link = "NA", reaction = rnames[j],
                         map = "NA", graphics = gdata.new)
  }
  names(ndata.new)=eid
#  gR=graph::addNode(eid, gR)
  gR=addNode(eid, gR)
}
  ndata.new=c(ndata,ndata.new)
  
#create edges for ECrel and maplink types of relationships
  slen=sapply(rdata.tab[,3], length)
  plen=sapply(rdata.tab[,5], length)
  glen=rn.len[match(rdata.tab[,"name"], rnames)]

  from1=to1=from2=to2=NULL
  for(i in 1:nrow(rdata.tab)){
    subs=rdata.tab[[i,"substrateName"]]
    prods=rdata.tab[[i,"productName"]]
    enzs=rn.grps[[rdata.tab[[i,"name"]]]]
    rtype=rdata.tab[[i,"type"]]
    from1=c(from1, rep(subs, each=glen[i]))
    to1=c(to1, rep(enzs, slen[i]))
    to2=c(to2, rep(prods, each=glen[i]))
    from2=c(from2, rep(enzs, plen[i]))
    if(rtype=="reversible"){
      to2=c(to2, rep(subs, each=glen[i]))
      from2=c(from2, rep(enzs, slen[i]))
      from1=c(from1, rep(prods, each=glen[i]))
      to1=c(to1, rep(enzs, plen[i]))
    }
  }
  names(from1)=names(from2)=names(to1)=names(to2)=NULL
  di1=duplicated(paste(from1, to1))
  di2=duplicated(paste(from2, to2))
  from1=from1[!di1]
  to1=to1[!di1]
  from2=from2[!di2]
  to2=to2[!di2]


#revise edges on the graph  
  if(len.ed>0){
    eci1=edata.tab[,"type"]=="ECrel"
    eci2=edata.tab[,"type"]=="maplink"
    eci=eci1|eci2
    gene1=edata.tab[eci1,"entry1ID"]
    gene2=edata.tab[eci1,"entry2ID"]
    mln1=edata.tab[eci2,"entry1ID"]
    mln2=edata.tab[eci2,"entry2ID"]
    cpd=edata.tab[eci2,"subtype.value"]
    if(sum(eci)>0) gR=removeEdge(from=c(gene1,mln1), to=c(gene2,mln2), graph=gR)
    if(sum(eci2)>0) gR=addEdge(from=cpd, to=mln2, graph=gR)
  }
  gR=addEdge(from=from1, to=to1, graph=gR)
                                        #may overlap with maplink edges
  gR=addEdge(from=from2, to=to2, graph=gR)

#revise edge.data
  st1=new("KEGGEdgeSubType", name="compound", value="NA")
  other.args=list(Class="KEGGEdge",type = "CErel", subtype = list(subtype=st1))
  edata1=mapply(new, entry1ID = from1, entry2ID = to1, MoreArgs=other.args)
  other.args=list(Class="KEGGEdge",type = "ECrel", subtype = list(subtype=st1))
  edata2=mapply(new, entry1ID = from2, entry2ID = to2, MoreArgs=other.args)
  other.args=list(Class="KEGGEdge",type = "ECrel", subtype = list(subtype=st1))#"maplink"
  edata3=NULL
  if(len.ed>0){
    if(sum(eci2)>0){
      other.args=list(Class="KEGGEdge",type = "maplink", subtype = list(subtype=st1))
      edata3=mapply(new, entry1ID = cpd, entry2ID = mln2, MoreArgs=other.args)
    }
  }
  edata.new=c(edata1, edata2, edata3)
  if(len.ed>0) edata.new=c(edata[!eci],edata.new)
  return(list(gR, edata.new, ndata.new))
}

