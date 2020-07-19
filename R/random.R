random <-
function(x, na.rm=TRUE){
if(na.rm) x=x[!is.na(x)]
lenx=length(x)
if(lenx==0) return(NA)
ifelse(lenx==1, x, sample(x, 1))
}
