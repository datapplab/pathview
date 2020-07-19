col.key <-
  function(discrete=FALSE, limit=1.0, bins=10, cols=NULL, both.dirs=TRUE, low="green", mid="gray", high="red", graph.size, node.size, size.by.graph=TRUE, key.pos="topright", off.sets=c(x=0,y=0), align="n",  cex=1, lwd=1){

  if(both.dirs & length(limit)==1){
    limit=c(-abs(limit), abs(limit))
  } else if(length(limit)==1){
    limit=c(0,limit)
  }
  disc.cond1=all(as.integer(limit)==limit)
  disc.cond2=(limit[2]-limit[1]) %% bins==0
  discrete=discrete & disc.cond1 & disc.cond2
  if(discrete){
    limit[2]=limit[2]+1
    bins=bins+1
  }

  width=graph.size[1]
  height=graph.size[2]
  if(size.by.graph==T){
    xs=width/80
    ys=height/40
  } else if(!missing(node.sizes)){
    xs=node.size[1]*3/bins
    ys=node.size[2]
  } else{
    message("Note: ", "color key not plotted, node.size is needed\n when size.by.graph=FALSE!")
    return(off.sets)
  }
  
  if(align=="x") {
    off.sets['x']=2*xs
    off.sets['y']=off.sets['y']+3*ys
  }
  if(align=="y")   off.sets=off.sets+c(x=3*xs, y=0)
  if(align=="n")   off.sets=off.sets+c(x=2*xs, y=2*ys)
  if(length(grep('right',key.pos))==1) {
    off.sets['x']=off.sets['x']+bins*xs
    x=width-off.sets['x']
  } else {
    x=off.sets['x']
    off.sets['x']=off.sets['x']+bins*xs
  }
  if(length(grep('top',key.pos))==1) y=height-off.sets['y'] else y=off.sets['y']

  ckx=seq(x,x+bins*xs,length=bins+1)
  cky=c(y,y+ys)

  if(is.null(cols)){
     if(both.dirs){
    cols = colorpanel2(bins, low=low, mid=mid, high=high)
  } else cols = colorpanel2(bins, low=mid, high=high)
   }

  data.cuts = seq(from = limit[1], to =limit[2], length=bins+1)
  image(x=ckx, y=cky, z=cbind(data.cuts[-1]),col = cols, axes = FALSE, add=T)
if(!discrete){
  label=format(data.cuts[c(1,bins/2+1,bins+1)], digits=2)
  text(x=seq(x,x+bins*xs,length=length(label)), y=rep(y-ys, length(label)),label=label, cex=cex)
  } else{
  label=paste(as.integer(data.cuts[c(1,bins)]))
  text(x=seq(x,x+bins*xs,length=length(label))+c(xs,-xs)/2, y=rep(y-ys, length(label)),label=label, cex=cex)
  }
  cky=c(y-0.25*ys,y+ys)
  for(i in 1:(bins+1)) lines(rep(ckx[i],2), cky, lwd=lwd)

  return(off.sets)
}

