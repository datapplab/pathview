geneannot.map <- function(in.ids, in.type, out.type, org="Hs", pkg.name=NULL, unique.map=TRUE, na.rm=TRUE, keep.order=TRUE){
  if(is.null(pkg.name)) {#pkg.name=paste("org", org, "eg.db", sep=".")
    data(bods)
    ridx=grep(tolower(paste0(org, "[.]")), tolower(bods[,1]))
    if(length(ridx)==0) {
      ridx=grep(tolower(org), tolower(bods[,2:3])) %% nrow(bods)
      if(length(ridx)==0) stop("Wrong org value!")
      if(any(ridx==0)) ridx[ridx==0]=nrow(bods)
    }
    pkg.name=bods[ridx,1]
  }

  pkg.on=try(requireNamespace(pkg.name),silent = TRUE)
  if(!pkg.on) {
#    source("http://bioconductor.org/biocLite.R")
#    biocLite(pkg.name, suppressUpdates =TRUE)
    BiocManager::install(pkg.name, update=FALSE)
    pkg.on=try(requireNamespace(pkg.name),silent = TRUE)
    if(!pkg.on) stop(paste("Fail to install/load gene annotation package ", pkg.name, "!",  sep=""))
  }
  
  
  db.obj <- eval(parse(text=paste0(pkg.name, "::", pkg.name)))
  id.types <- columns(db.obj) #columns(eval(as.name(pkg.name)))

  in.type=toupper(in.type)
  out.type=toupper(out.type)
  eii=in.type==toupper("entrez") | in.type==toupper("eg")
  if(any(eii)) in.type[eii]="ENTREZID"
  eio=out.type==toupper("entrez") | out.type==toupper("eg")
  if(any(eio)) out.type[eio]="ENTREZID"
  if(all(in.type==out.type)) stop("in.type and out.type are the same, no need to map!")
  
  nin=length(in.type)
  if(nin!=1) stop("in.type must be of length 1!")
  out.type=out.type[!out.type %in% in.type]
  nout=length(out.type)
  
  msg <-  paste0("must from: ", paste(id.types, collapse=", "), "!")
  if (! in.type %in% id.types) stop("'in.type' ", msg)
  if (! all(out.type %in% id.types)) stop("'out.type' ", msg)

  in.ids0=in.ids
  in.ids <- unique(as.character(in.ids))#unique necessary for select()# if(unique.map)
  out.ids=character(length(in.ids))
  res <- try(suppressWarnings(AnnotationDbi::select(db.obj,
                                     keys = in.ids,
                                     keytype = in.type,
                                     columns=c(in.type, out.type))))
  if(class(res)[1]=="data.frame"){
    
    res <- res[, c(in.type, out.type)]

    if(nout==1) na.idx <- is.na(res[,2])
    else na.idx <- apply(res[,-1],1,function(x) all(is.na(x)))
    if (sum(na.idx)>0) {
      n.na <- length(unique(res[na.idx, 1]))
      if (n.na>0) {
        print(paste("Note:", n.na, "of", length(in.ids), "unique input IDs unmapped."))
      }
      if (na.rm) res <- res[!na.idx, ]
    }

    cns=colnames(res)
    if(unique.map){
      if(length(out.type)==1)  umaps=tapply(res[,out.type], res[,in.type], paste, sep="", collapse="; ")
      else umaps=apply(res[,out.type], 2, function(x) tapply(x, res[,in.type], function(y) paste(unique(y), sep="", collapse="; ")))
      umaps=cbind(umaps)
      res.uniq=cbind(rownames(umaps), umaps)
      res=res.uniq
      colnames(res)=cns
    }

    res=as.matrix(res)
    if(!keep.order){
      rownames(res)=NULL
      return(res)
    } else {
      res1=matrix(NA, ncol=length(cns), nrow=length(in.ids0))
      res1[,1]=in.ids0
      rns=match(in.ids0, res[,1])
      res1[,-1]=res[rns,-1]
      colnames(res1)=cns
      return(res1)
    }
  } else{
    res=cbind(in.ids,out.ids)
    colnames(res)=c(in.type,out.type)
    return(res)
  }
}
