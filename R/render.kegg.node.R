render.kegg.node <-
function(plot.data, cols.ts, img, same.layer=TRUE, type=c("gene","compound")[1], text.col="black", cex=0.25){
  width=ncol(img)
  height=nrow(img)
  nn=nrow(plot.data)
  pwids=plot.data$width
  if(!all(pwids==max(pwids))){
    message("Info: ", "some node width is different from others, and hence adjusted!")
    wc=table(pwids)
    pwids=plot.data$width=as.numeric(names(wc)[which.max(wc)])
  }

  if(type=="gene"){
  if(same.layer!=T){
    rect.out=sliced.shapes(plot.data$x+0.5, height-plot.data$y, plot.data$width/2-0.5, plot.data$height/2-0.25,  cols=cols.ts, draw.border=F, shape="rectangle")
    text(plot.data$x+0.5, height-plot.data$y, labels = as.character(plot.data$labels),
         cex = cex, col = text.col)
    return(invisible(1))
  } else{
    img2=img
    pidx=cbind(ceiling(plot.data$x-plot.data$width/2)+1,
      floor(plot.data$x+plot.data$width/2)+1,
      ceiling(plot.data$y-plot.data$height/2)+1,
      floor(plot.data$y+plot.data$height/2)+1)
    cols.ts=cbind(cols.ts)
    ns=ncol(cols.ts)
    brk.x= sapply(plot.data$width/2, function(wi) seq(-wi, wi, length = ns+1))
    for(k in 1:ns){
      col.rgb=col2rgb(cols.ts[,k])/255
      pxr=t(apply(pidx[,1:2], 1, function(x) x[1]:x[2]))-plot.data$x-1
      sel=pxr>=ceiling(brk.x[k,]) & pxr<=floor(brk.x[k+1,])
      for(i in 1:nn){
      sel.px=(pidx[i,1]:pidx[i,2])[sel[i,]]
      node.rgb=img[pidx[i,3]:pidx[i,4],sel.px, 1:3]
      node.rgb.sum=apply(node.rgb,c(1,2), sum)
      blk.ind=which(node.rgb.sum==0|node.rgb.sum==1,arr.ind=T)
      node.rgb=array(col.rgb[,i],dim(node.rgb)[3:1])
      node.rgb=aperm(node.rgb, 3:1)
      for(j in 1:3) node.rgb[cbind(blk.ind,j)]=0
      img2[pidx[i,3]:pidx[i,4],sel.px, 1:3]=node.rgb
    }
  }
    return(img2)
  }
} else if(type=="compound"){
  if(same.layer!=T){
    nc.cols=ncol(cbind(cols.ts))
    if(nc.cols>2){#block the background circle
      na.cols=rep("#FFFFFF", nrow(plot.data))
      cir.out=sliced.shapes(plot.data$x, height-plot.data$y, plot.data$width[1], plot.data$width[1], cols=na.cols, draw.border=F, shape="ellipse", lwd=0.2)
    }
    cir.out=sliced.shapes(plot.data$x, height-plot.data$y, plot.data$width[1], plot.data$width[1], cols=cols.ts, shape="ellipse", blwd=0.2)
    return(invisible(1))
  } else{
#    col.rgb=col2rgb(cols.ts)/255
    blk=c(0,0,0)
    img2=img
    w=ncol(img) #repeat
    h=nrow(img) #repeat
    cidx=rep(1:w, each=h)
    ridx=rep(1:h, w)
    pidx=lapply(1:nn, function(i){
      ii=which((cidx-plot.data$x[i])^2+(ridx-plot.data$y[i])^2<(plot.data$width[i])^2)
      imat=cbind(cbind(ridx, cidx)[rep(ii,each=3),],1:3)
      imat[,1:2]=imat[,1:2]+1
      ib=which(abs((cidx-plot.data$x[i])^2+(ridx-plot.data$y[i])^2-(plot.data$width[i])^2)<=8)
      ibmat=cbind(cbind(ridx, cidx)[rep(ib,each=3),],1:3)
      ibmat[,1:2]=ibmat[,1:2]+1
      return(list(fill=imat,border=ibmat))
    })

    cols.ts=cbind(cols.ts)
    ns=ncol(cols.ts)
    brk.x= sapply(plot.data$width, function(wi) seq(-wi, wi, length = ns+1))
    for(i in 1:nn){
      pxr=pidx[[i]]$fill[,2]-1-plot.data$x[i]
      col.rgb=col2rgb(cols.ts[i,])/255
      for(k in 1:ns){
        sel=pxr>=brk.x[k,i] & pxr<=brk.x[k+1,i]
        img2[pidx[[i]]$fill[sel,]]=col.rgb[,k]
      }
      img2[pidx[[i]]$border]=blk
    }
    return(img2)
  }
} else stop("unrecognized node type!")
}

