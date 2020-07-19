circles <-
function(x0,y0,r,n=100, cols, ...){
  theta <- seq(0, 2 * pi, length=n)
  x=matrix(rep(x0, each=n), nrow=n)
  y=matrix(rep(y0, each=n), nrow=n)
  x <- x + r * cos(theta)
  y <- y + r * sin(theta)
  for(i in 1:length(x0)) polygon(x[,i], y[,i], col=cols[i], ...)
  return(list(x,y))
}

