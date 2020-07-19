ellipses <-
function(x0,y0,w,h,n=100, cols, ...){
  np=length(x0)
  x=seq(-w,w,length=n/2)
  y=(1-(x/w)^2)^.5*h
  x=c(x,rev(x))
  y=c(y,-rev(y))
  x0=matrix(rep(x0, each=n), nrow=n)
  y0=matrix(rep(y0, each=n), nrow=n)
  x <- x0 + x
  y <- y0 + y
  for(i in 1:np) polygon(x[,i], y[,i], col=cols[i], ...)
  return(list(x,y))
}

