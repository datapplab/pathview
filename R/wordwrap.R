wordwrap <-
function(s, width=20, break.word=FALSE){
  if(!break.word) {
    wrapped=paste(strwrap(s,width),collapse="\n")
  } else     wrapped=strfit(s,width)
  return(wrapped)
}

