cpdidmap <-
function(in.ids, in.type, out.type){
#map between cpd ids, both kegg and others
  cnames=c(in.type, out.type)
  in.type=tolower(in.type)
  out.type=tolower(out.type)
  data(rn.list)
  cpd.type=names(rn.list)=tolower(names(rn.list))
  
  if(!in.type %in% cpd.type) stop("Incorrect type!")
  if(out.type=="kegg")  kg.idx=grep("kegg", cpd.type)
  else if(out.type %in% cpd.type) kg.idx=which(cpd.type==out.type)
  else stop("Incorrect out.type!")
  if(in.type %in% cpd.type[kg.idx]) {
    message("Note: ", "A native KEGG compound ID type, no need to map!")
    return(invisible(0))
  }
  in.ids=in.ids[!is.na(in.ids)]
#  in.ids=unique(in.ids)
  len.id=length(in.ids)
  kg.accs=rep(NA, len.id)
  
  data(cpd.accs)
  accs.intype=cpd.accs[rn.list[[in.type]], ]
  in.idx=in.ids  %in% accs.intype$ACCESSION_NUMBER
  if(sum(in.idx)<1) {#stop("None of the compound ids mapped to the specified type!")
    message("Note: ", "None of the compound ids mapped to the specified type!")
  } else{
    rev.idx=accs.intype$ACCESSION_NUMBER %in% in.ids
    if(sum(rev.idx)>sum(in.idx)) message("Note: ", "multiple compounds may map to a input ID, only the first one kept!")
    in.cpd=accs.intype$COMPOUND_ID[match(in.ids[in.idx], accs.intype$ACCESSION_NUMBER)]


    accs.kg=cpd.accs[unlist(rn.list[kg.idx]), ]
    map.idx=in.cpd %in% accs.kg$COMPOUND_ID
    if(sum(map.idx)<1) message("Note: ", "None of the compound ids mapped to specified output ID type(s)!")
    in.cpd=in.cpd[map.idx]
    cpd.idx=match(in.cpd, accs.kg$COMPOUND_ID)
    kg.accs[in.idx][map.idx]=as.character(accs.kg$ACCESSION_NUMBER[cpd.idx])
  }
  kg.accs=cbind(in.ids, kg.accs)
  colnames(kg.accs)=cnames
  return(kg.accs)
}

