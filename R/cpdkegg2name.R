cpdkegg2name <-
function(in.ids, in.type=c("KEGG", "KEGG COMPOUND accession")[1]){
#kegg accession to cpd name
  cnames=c(in.type, "NAME")
  in.type=tolower(in.type)
#  out.type=tolower(out.type)
  data(rn.list)
  cpd.type=names(rn.list)=tolower(names(rn.list))
    cpd.type=c(cpd.type,"kegg")
    kg.type=cpd.type[grep("kegg", cpd.type)]
    if(!in.type %in% kg.type) stop("Incorrect type!")
    in.type=gsub(" accession", "", in.type)

  data(cpd.names)
    if(in.type=="kegg") sel.rn=1:nrow(cpd.names)
  else sel.rn=cpd.names$SOURCE==in.type
    sel.cn=c("ACCESSION_NUMBER", "NAME")
      cpd.names=as.matrix(cpd.names[sel.rn, sel.cn])
    rownames(cpd.names)=NULL
  data(kegg.met)
    cpd.names=as.data.frame(rbind(kegg.met[,1:2],cpd.names))
  colnames(cpd.names)=sel.cn    #@

#  in.ids=unique(in.ids)
  len.id=length(in.ids)
      out.names=in.ids
#  out.names=rep(NA, len.id)

  in.idx=in.ids  %in% cpd.names$ACCESSION_NUMBER
  if(sum(in.idx)<1) {
    message("Note: ", "None of the compound ids mapped to the specified type!")
  } else{
    out.names[in.idx]=as.character(cpd.names$NAME[match(in.ids[in.idx], cpd.names$ACCESSION_NUMBER)])
  }
  out.names=cbind(in.ids, out.names)
  colnames(out.names)=cnames
  return(out.names)
}

