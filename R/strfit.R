strfit <-
function(s, width=20){
  spaces=c(" ", "\t", "\n")
  s=gsub("([ \t\n])+"," ", s) #  s=gsub("([ \t\n])+","\\1", s)
  sv=strsplit(s, "")[[1]]
  len.s=length(sv)
  passed=NULL

  while(len.s>0){
    if (length(sv)<width+3) {
      passed=c(passed, s)
      break
    }
    
    start.pos=1
    if(sv[width] %in% spaces){
      stop.pos=width-1
      start.next=width+1
      postpend=""
    } else if(sv[width+1] %in% spaces){
      stop.pos=width
      start.next=width+2
      postpend=""
    } else if(sv[width+2] %in% spaces){
      stop.pos=width+1
      start.next=width+3
      postpend=""
    } else if(sv[width-1] %in% spaces){
      stop.pos=width-2
      start.next=width
      postpend=""
    } else if(sv[width-2] %in% spaces){
      stop.pos=width-3
      start.next=width-1
      postpend="\\"
    } else{
      stop.pos=width
      start.next=width+1
      postpend="\\"
    }

    passed=c(passed, paste(substr(s, start.pos, stop.pos), postpend, sep=""))
    start.pos=start.next
    s=substr(s, start.pos, length(sv))
    sv=sv[-c(1:(start.pos-1))]
    len.s=length(sv)
  }
  passed=paste(passed, collapse="\n")
  return(passed)    
}

