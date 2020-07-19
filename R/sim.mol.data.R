sim.mol.data=function(mol.type=c("gene","gene.ko","cpd")[1], id.type=NULL, species="hsa", discrete=FALSE, nmol=1000, nexp=1, rand.seed=100)
{
  msg.fmt="\"%s\" is not a good \"%s\" \"%s\" ID type for simulation!"
  msg.fmt2="\"%s\" has only %i unique IDs!"
  set.seed(rand.seed)

  species=species[1]
  if(species!="ko"){
    species.data=kegg.species.code(species, na.rm=T, code.only=FALSE)
    species=species.data["kegg.code"]
  } else if(mol.type=="gene") mol.type="gene.ko"
  
  
  if(mol.type=="gene"){
    if(is.null(id.type)) id.type="KEGG"
    id.type=toupper(id.type)
    if(id.type=="ENTREZ") id.type="ENTREZID"
      kid.map=names(species.data)[-c(1:2)]
      kid.types=names(kid.map)=c("KEGG", "ENTREZID", "NCBIPROT", "UNIPROT")
      kid.map2=gsub("[.]", "-", kid.map)
      kid.map2["UNIPROT"]="up"

    data(bods)
    data(gene.idtype.bods)
    org19=bods[,"kegg code"]

    kegg.mapping=F
    if(species %in% org19){
      if(!id.type %in% gene.idtype.bods[[species]]) kegg.mapping=T
     } else if (species != "ko") kegg.mapping=T
#      print(kegg.mapping)

    if(kegg.mapping){#!species %in% c(org19, "ko") | id.type %in% kid.types[c(1,3)]){
      if(!id.type %in% kid.types){
        msg=sprintf(msg.fmt, id.type, species, mol.type)
        stop(msg)
      }
      if(is.na(species.data[kid.map[id.type]])){
        if(!is.na(species.data["kegg.geneid"])){
          msg.fmt3="Only native KEGG gene ID is supported for species \"%s\"! Use KEGG ID instead."
          msg=sprintf(msg.fmt3, species)
          message("Note: ", msg)
          id.type="KEGG"
        } else{
          msg.fmt3="Simulation is not supported for species \"%s\"!"
          msg=sprintf(msg.fmt3, species)
          stop(msg)
        }
      }

         if(id.type=="KEGG") {
           gid.map=keggList(species)
           all.mn=gsub(paste(species, ":", sep=""), "", names(gid.map))
         } else {
           gid.map=keggConv(kid.map2[id.type],species)
           all.mn=gsub(paste0(kid.map2[id.type],":"), "", gid.map)
         }
    } else if(species %in% org19){
#      if(id.type=="ENTREZ") id.type="ENTREZID"
      if(id.type=="KEGG") {
        gid.map=keggConv("ncbi-geneid",species)        
        all.mn=gsub(paste(species, ":", sep=""), "", names(gid.map))
      } else if(id.type %in% gene.idtype.bods[[species]]){
        idx=which(bods[,3]==species)
        pkg.name=bods[idx,1]
        pkg.on=requireNamespace(pkg.name)
        if(!pkg.on) {
#          source("http://bioconductor.org/biocLite.R")
#          biocLite(pkg.name, suppressUpdates =TRUE)
          BiocManager::install(pkg.name, update=FALSE)
          pkg.on=requireNamespace(pkg.name)
          if(!pkg.on) stop(paste("Fail to install/load gene annotation package ", pkg.name, "!",  sep=""))
        }
        
        db.obj <- eval(parse(text=paste0(pkg.name, "::", pkg.name)))
        all.mn <-keys(db.obj, keytype=id.type)
      } else stop("Wrong gene ID type!")
    }            
  } else if(mol.type=="cpd"){
    data(cpd.accs)
    data(cpd.simtypes)
    data(rn.list)
    accn=cpd.accs$ACCESSION_NUMBER
    if(is.null(id.type)) id.type="KEGG COMPOUND accession"
    if(!id.type %in% cpd.simtypes){
      msg=sprintf(msg.fmt, id.type, mol.type)
      stop(msg)
    }
    all.mn=unique(as.character(accn[rn.list[[id.type]]]))
  } else if(mol.type=="gene.ko"){
    data(ko.ids)
    all.mn=ko.ids
  } else stop("Invalid mol.type!") 

  nuids=length(all.mn)
  if(nmol>nuids){
    msg=sprintf(msg.fmt2, id.type, nuids)
    message("Note: ", msg)
    nmol=nuids
  }
  sel.mn=sample(all.mn, nmol)
  if(discrete) return(sel.mn)
  sel.mn.data=matrix(rnorm(nmol*nexp), ncol=nexp)
  rownames(sel.mn.data)=sel.mn
  colnames(sel.mn.data)=paste("exp", 1:nexp, sep="")
  return(sel.mn.data[, 1:nexp])
}

