node.color <-
  function(plot.data=NULL, discrete=FALSE, limit=1, bins=10, both.dirs=TRUE, low="green", mid="gray", high="red", na.col="transparent", trans.fun=NULL){
    if(is.null(plot.data)) return(NULL)
  node.summary=plot.data[,-c(1:8)]#c(1:7)
  if(length(dim(node.summary))==2) {
    node.summary=as.matrix(node.summary)
    } else names(node.summary)=rownames(plot.data)
  if(!is.null(trans.fun)) node.summary=trans.fun(node.summary)
if(both.dirs & length(limit)==1){
    limit=c(-abs(limit), abs(limit))
  } else if(length(limit)==1){
    limit=c(0,limit)
  }
    disc.cond1=all(as.integer(limit)==limit)
    disc.cond2=(limit[2]-limit[1]) %% bins==0
    if(discrete & disc.cond1 & disc.cond2){
      node.summary[]=as.integer(node.summary)
      limit[2]=limit[2]+1
      bins=bins+1
    } else if(discrete){
      message("Note: ", "limit or bins not proper, data not treated as discrete!")
    }

  
  node.summary[node.summary > limit[2]] = limit[2]
  node.summary[node.summary < limit[1]] = limit[1]
  if(both.dirs){
    cols = colorpanel2(bins, low=low, mid=mid, high=high)
  } else cols = colorpanel2(bins, low=mid, high=high)
  na.col=colorpanel2(1, low=na.col, high=na.col)
  data.cuts = seq(from = limit[1], to =limit[2], length=bins+1)
  index.ts = cols.ts = node.summary
  index.ts[] = cut(node.summary, data.cuts, include.lowest = TRUE, right=F)
  cols.ts[]=cols[index.ts]
  cols.ts[is.na(cols.ts)]=na.col
  return(cols.ts)
}

