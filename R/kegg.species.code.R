kegg.species.code <-
  function(species="hsa", na.rm=FALSE, code.only=TRUE){
    nspec=length(species)
    if(!exists("korg")) data(korg, package="pathview")

    ridx=match(species, korg[,1:5]) %% nrow(korg)
    nai=is.na(ridx)
    if(sum(nai)>0) {
      si=try(load(url("https://pathview.uncc.edu/data/korg.1.rda")))
      if(class(si)[1]!="try-error"){
        ridx.1=match(species, korg.1[,1:5]) %% nrow(korg.1)
        nai.1=is.na(ridx.1)
        if(sum(nai.1)<sum(nai)){
          korg=korg.1
          ridx=ridx.1
          nai=nai.1
        }
      }

      if(sum(nai)>0) {
        na.msg=sprintf("Unknown species '%s'!", paste(species[nai], sep="", collapse="', '"))
        message("Note: ", na.msg)
      }
      if(sum(nai)==nspec) {
        stop.msg="All species are invalid!"
        stop(stop.msg)
      }
    }
    if(any(ridx[!nai]==0)) ridx[!nai & ridx==0]=nrow(korg)
    if(na.rm) ridx=ridx[!nai]
    if(code.only) coln=3 else coln=c(3,6:10)
    species.info=korg[ridx,coln]
    return(species.info)
  }

