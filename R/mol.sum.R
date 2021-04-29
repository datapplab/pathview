mol.sum <-
function(mol.data, id.map, gene.annotpkg="org.Hs.eg.db", sum.method=c("sum","mean", "median", "max", "max.abs", "random")[1]){
  if(is.character(mol.data)){
    gd.names=mol.data
    mol.data=rep(1, length(mol.data))
    names(mol.data)=gd.names
    ng=length(mol.data)
  } else if(!is.null(mol.data)){
    if(length(dim(mol.data))==2){
    gd.names=rownames(mol.data)
    ng=nrow(mol.data)
    } else if(is.numeric(mol.data) & is.null(dim(mol.data))){
    gd.names=names(mol.data)
    ng=length(mol.data)
    } else stop("wrong mol.data format!")
  } else stop("NULL mol.data!")

  if(is.character(id.map) & length(id.map)==1){
    id.map=id2eg(gd.names, category=id.map, pkg.name=gene.annotpkg)
  }
  
  sel.idx=id.map[,2]>"" & !is.na(id.map[,2])
  id.map=id.map[sel.idx,,drop=F]
  eff.idx=gd.names %in% id.map[,1]
  mapped.ids=id.map[match(gd.names[eff.idx], id.map[,1]),2]
  if(sum(eff.idx)<1) stop("no ID can be mapped!")
  else if(sum(eff.idx)==1){
    mapped.data=cbind(mol.data)[eff.idx,,drop=F] #rbind(cbind(mol.data)[eff.idx,])
    rownames(mapped.data)=mapped.ids[1]
  }
  else{
    if(sum.method %in% c("sum","mean")){
      sum.method=eval(as.name(sum.method))
#      mapped.data=apply(cbind(cbind(mol.data)[eff.idx,]),2,function(x){      
      mapped.data=apply(cbind(mol.data)[eff.idx,,drop=F],2,function(x){
        sum.res=tapply(x, mapped.ids, sum.method, na.rm=T)
        return(sum.res)
      })
      if(length(unique(mapped.ids))==1){
        if(length(mapped.data)>1){
          mapped.data=rbind(mapped.data)
          rownames(mapped.data)=mapped.ids[1]
        }
        else names(mapped.data)=mapped.ids[1]
      }
    } else{
    sum.method=eval(as.name(sum.method))
    mol.data=cbind(mol.data)[eff.idx,,drop=F] #cbind(cbind(mol.data)[eff.idx,])
    if(all(mol.data>=0) | all(mol.data<=0)){
      vars=apply(cbind(mol.data), 1, IQR)
    } else vars=apply(cbind(mol.data), 1, sum, na.rm=T)
    
    sel.rn=tapply(1:sum(eff.idx), mapped.ids, function(x){
#    sel.rn=tapply(which(eff.idx), mapped.ids, function(x){
      if(length(x)==1) return(x)
      else return(x[which.min(abs(vars[x]-sum.method(vars[x], na.rm=T)))])
    })
#    if(length(sel.rn)>1) mapped.data=cbind(mol.data[sel.rn,])
#    else mapped.data=mol.data[sel.rn,,drop=F] #rbind(mol.data[sel.rn,])
    mapped.data=mol.data[sel.rn,,drop=F]
    rownames(mapped.data)=names(sel.rn)
  }
}
  return(mapped.data)

}

