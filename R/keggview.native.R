keggview.native <-
function(
                         plot.data.gene=NULL,
                          plot.data.cpd=NULL,
                         cols.ts.gene=NULL,
                          cols.ts.cpd=NULL,
                         node.data,
                         pathway.name,
                           out.suffix="pathview",
                         kegg.dir=".",

                          multi.state=TRUE,
                          match.data=TRUE,
                           same.layer=TRUE, #
                         res=300, #
                         cex = 0.25,#

         discrete=list(gene=FALSE, cpd=FALSE),
         limit=list(gene=1, cpd=1),
                         bins=list(gene=10, cpd=10),
                         both.dirs=list(gene=T, cpd=T),
         low = list(gene = "green", cpd = "blue"),
                         mid = list(gene = "gray", cpd = "gray"),
                         high = list(gene = "red", cpd = "yellow"),
         na.col="transparent",
#         na.col="white",
         
                         new.signature=TRUE,
                         plot.col.key=TRUE,
                         key.align="x",
                         key.pos="topright",
#                         sign.pos="bottomright",#g
                         ...){

#read image  
  img <- readPNG(paste(kegg.dir, "/", pathway.name, ".png", 
                       sep = ""))
  width <- ncol(img)
  height <- nrow(img)

  cols.ts.gene=cbind(cols.ts.gene)
  cols.ts.cpd=cbind(cols.ts.cpd)
  nc.gene=max(ncol(cols.ts.gene),0)
  nc.cpd=max(ncol(cols.ts.cpd),0)#@
  nplots=max(nc.gene,nc.cpd)
  pn.suffix=colnames(cols.ts.gene)
  if(length(pn.suffix)<nc.cpd)  pn.suffix=colnames(cols.ts.cpd)
  if(length(pn.suffix)<nplots)  pn.suffix=1:nplots #no column names for both datasets
  if(length(pn.suffix)==1) {
    pn.suffix=out.suffix
  } else pn.suffix=paste(out.suffix, pn.suffix, sep=".")

     na.col=colorpanel2(1, low=na.col, high=na.col)
  if((match.data | !multi.state) & nc.gene!=nc.cpd){
#  if(nc.gene>nc.cpd) cols.ts.cpd= cols.ts.cpd[, rep(1:nc.cpd, nplots)[1:nplots]]
#  if(nc.gene<nc.cpd) cols.ts.gene= cols.ts.gene[, rep(1:nc.gene, nplots)[1:nplots]]

     if(nc.gene>nc.cpd & !is.null(cols.ts.cpd)){
      na.mat=matrix(na.col, ncol=nplots-nc.cpd, nrow=nrow(cols.ts.cpd))
      cols.ts.cpd= cbind(cols.ts.cpd, na.mat)
    }
    if(nc.gene<nc.cpd & !is.null(cols.ts.gene)){
      na.mat=matrix(na.col, ncol=nplots-nc.gene, nrow=nrow(cols.ts.gene))
      cols.ts.gene= cbind(cols.ts.gene, na.mat)
    }
    nc.gene=nc.cpd=nplots
  }
  
  out.fmt="Working in directory %s"
  wdir=getwd()
  out.msg=sprintf(out.fmt, wdir)
  message("Info: ", out.msg)
  out.fmt="Writing image file %s"

    multi.state=multi.state & nplots>1
if(multi.state) {
  nplots=1
  pn.suffix=paste(out.suffix, "multi", sep=".")
  if(nc.gene>0) cols.gene.plot=cols.ts.gene
  if(nc.cpd>0) cols.cpd.plot=cols.ts.cpd
}

for(np in 1:nplots){
#plot setup
 img.file =paste(pathway.name,pn.suffix[np],"png", sep=".")
 out.msg=sprintf(out.fmt, img.file)
 message("Info: ", out.msg)
  png(img.file, width = width, height = height, res=res)

  op=par(mar = c(0, 0, 0, 0))
  plot(c(0, width), c(0, height), type = "n", xlab = "", ylab = "",xaxs = "i",yaxs = "i")
  if(new.signature) img[height-4:25, 17:137, 1:3]=1
  if(same.layer!=T)  rasterImage(img, 0, 0, width, height, interpolate = F)
  
if(!is.null(cols.ts.gene) & nc.gene>=np){
    if(!multi.state) cols.gene.plot=cols.ts.gene[,np]
    if(same.layer!=T){
      render.kegg.node(plot.data.gene, cols.gene.plot, img, same.layer=same.layer, type="gene", cex=cex)
  } else{
  img=render.kegg.node(plot.data.gene, cols.gene.plot, img, same.layer=same.layer, type="gene")
  }
} 

if(!is.null(cols.ts.cpd) & nc.cpd>=np){
    if(!multi.state) cols.cpd.plot=cols.ts.cpd[,np]
  if(same.layer!=T){
      render.kegg.node(plot.data.cpd, cols.cpd.plot, img, same.layer=same.layer, type="compound", cex=cex)
  } else{
  img=render.kegg.node(plot.data.cpd, cols.cpd.plot, img, same.layer=same.layer, type="compound")
  }
}
  
  if(same.layer==T)  rasterImage(img, 0, 0, width, height, interpolate = F)

  pv.pars=list()
  pv.pars$gsizes=c(width=width, height=height)
  pv.pars$nsizes=c(46,17)
  pv.pars$op=op
  pv.pars$key.cex=2.*72/res
  pv.pars$key.lwd=1.2*72/res
  pv.pars$sign.cex=cex
  off.sets=c(x=0,y=0)
  align="n"

# na.col=colorpanel2(1, low=na.col, high=na.col)
 ucol.gene=unique(as.vector(cols.ts.gene))
 na.col.gene=ucol.gene %in% c(na.col, NA)

  if(plot.col.key & !is.null(cols.ts.gene) & !all(na.col.gene))  {
    off.sets=col.key(limit=limit$gene, bins=bins$gene, both.dirs=both.dirs$gene, discrete=discrete$gene, graph.size=pv.pars$gsizes,
      node.size=pv.pars$nsizes, key.pos=key.pos, cex=pv.pars$key.cex, lwd=pv.pars$key.lwd, low=low$gene, mid=mid$gene, high=high$gene, align="n")
    align=key.align
    
  }
  
 ucol.cpd=unique(as.vector(cols.ts.cpd))
 na.col.cpd=ucol.cpd %in% c(na.col, NA)
  if(plot.col.key & !is.null(cols.ts.cpd) & !all(na.col.cpd)) {
    off.sets=col.key(limit=limit$cpd, bins=bins$cpd, both.dirs=both.dirs$cpd, discrete=discrete$cpd, graph.size=pv.pars$gsizes, node.size=pv.pars$nsizes, key.pos=key.pos, off.sets=off.sets, cex=pv.pars$key.cex, lwd=pv.pars$key.lwd, low=low$cpd, mid=mid$cpd, high=high$cpd, align=align)
  }
  
  if(new.signature) pathview.stamp(x=17, y=20, on.kegg=T, cex = pv.pars$sign.cex)
  par(pv.pars$op)
  dev.off()
}
  
  return(invisible(pv.pars))
}

