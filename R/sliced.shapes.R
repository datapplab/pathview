sliced.shapes=function (x0, y0, w, h, n = 100, cols, shape=c("ellipse", "rectangle")[1], draw.border=TRUE, blwd=1, ...)
  {
    cols=cbind(cols)
    dd=dim(cols)
    ns=dd[2]
    n=(round(n/ns)*ns+1)*2
    nw=length(w)
#    if(length(w)==1) x = seq(-w, w, length = n/2)
    x = sapply(w, function(wi) seq(-wi, wi, length = n/2))
    
    if(is.character(shape)){
      if(shape=="ellipse") {
        y = (1 - (x/w)^2)^0.5 * h
      } else if(shape=="rectangle"){
        n=(ns+1)*2
#        x = seq(-w, w, length = n/2)
#        y = rep(h, length(x))
        x = sapply(w, function(wi) seq(-wi, wi, length = n/2))
        y=x
        y[]=h
      } else stop("Wrong shape specified!")
    } else if(is.function(shape)) y=shape(x)
    else stop("Wrong shape class specified!")

#    x = c(x, rev(x))
#    y = c(y, -rev(y))
    x=apply(x, 2, function(xj) c(xj, rev(xj)))
    y=apply(y, 2, function(yj) c(yj, -rev(yj)))
    
    np = length(x0)
    x0 = matrix(rep(x0, each = n), nrow = n)
    y0 = matrix(rep(y0, each = n), nrow = n)

    x1 <- x0 + x[,1:nw]
    y1 <- y0 + y[,1:nw]

    if(ns==1) {
      cols=cols[,1]
      bidx=if(draw.border) NULL else NA
      for (i in 1:np) polygon(x1[, i], y1[, i], col = cols[i], border=bidx, lwd=blwd, ...)
    } else{
#      brk.x=seq(-w, w, length = ns+1)
      brk.x= sapply(w, function(wi) seq(-wi, wi, length = ns+1))
      for (i in 1:np) {
        for(j in 1:ns){
          if(nw==1) sel=x>=brk.x[j] & x<=brk.x[j+1]
          else  sel=x[,i]>=brk.x[j,i] & x[,i]<=brk.x[j+1,i]
          polygon(x1[sel, i], y1[sel, i], col = cols[i, j], border=NA, ...)
        }
        if(draw.border) polygon(x1[, i], y1[, i], col = NA, lwd=blwd, ...)
      }
    }
    return(list(x, y))
  }
