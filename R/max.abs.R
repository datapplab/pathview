max.abs <-
function(x, na.rm=TRUE){
  if(na.rm) x=x[!is.na(x)]
  midx=which.max(abs(x))
  x[midx]
}

