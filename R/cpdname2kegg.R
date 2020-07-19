cpdname2kegg <-
function(in.ids){

  in.type="name"
#  in.ids=unique(in.ids)
  len.id=length(in.ids)
  kg.accs=rep(NA, len.id)

  data(cpd.names)
  in.idx=in.ids  %in% cpd.names$NAME
  if(sum(in.idx)<1){
    message("Note: ", "None of the compound ids mapped to the specified type!")
  } else{
    kg.accs[in.idx]=as.character(cpd.names$ACCESSION_NUMBER[match(in.ids[in.idx], cpd.names$NAME)])
  }
  kg.accs=cbind(in.ids, kg.accs)
  colnames(kg.accs)=c(in.type, "KEGG accession")
  return(kg.accs)
}

