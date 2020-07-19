cpd2kegg <-
function(in.ids, in.type){
#cpd id or name to kegg accession, use cpdname2kegg or cpdidmap
#  cpd.type=c(names(rn.list),"name")
data(rn.list)
cpd.type=tolower(c(names(rn.list),"name"))
  if(!tolower(in.type) %in% cpd.type) stop("Incorrect type!")
  kg.idx=grep("kegg", cpd.type)
  if(in.type %in% cpd.type[kg.idx]) stop("A native KEGG compound ID type, no need to map!")
  if(in.type=="name") {
    kg.accs=cpdname2kegg(in.ids)
  } else kg.accs=cpdidmap(in.ids, in.type=in.type, out.type="KEGG")
  
  return(kg.accs)
}

