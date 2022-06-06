download.kegg <-
  function (pathway.id = "00010", species = "hsa", kegg.dir = ".", file.type=c("xml", "png"))
  {
    npath=length(pathway.id)
    if(species!="ko") species=kegg.species.code(species, na.rm=T)
    nspec=length(species)

    if(npath!=1 | nspec!=1) {
      species=rep(species, npath)
      pathway.id=rep(pathway.id, each=nspec)
    }
    pathway.id <- paste(species, pathway.id, sep = "")
    uidx=!duplicated(pathway.id)
    pathway.id=pathway.id[uidx]
    species=species[uidx]
    npath=length(pathway.id)
    
    xml.fnames=paste(pathway.id, ".xml", sep="")
    png.fnames=paste(pathway.id, ".png", sep="")
    ##      xml.fmt="http://www.genome.jp/kegg-bin/download?entry=%s&format=kgml"
    ##      png.fmt="http://www.genome.jp/kegg/pathway/%s/%s"
    xml.fmt="https://rest.kegg.jp/get/%s/kgml"
    png.fmt="https://rest.kegg.jp/get/%s/image"
    all.status=rep("succeed", npath)
    names(all.status)=pathway.id
    warn.fmt.xml="Download of %s xml file failed!\nThis pathway may not exist!"
    warn.fmt.png="Download of %s png file failed!\nThis pathway may not exist!"
    

    if("xml" %in% file.type){
      for (i in 1:npath) {
        msg=sprintf("Downloading xml files for %s, %d/%d pathways..", pathway.id[i], i, length(pathway.id))
        message("Info: ", msg)
        xml.url=sprintf(xml.fmt,  pathway.id[i])
        xml.target=sprintf("%s/%s", kegg.dir, xml.fnames[i])
        xml.status=try(download.file(xml.url, xml.target, quiet=T), silent=T)

        if(xml.status!=0) all.status[i]="failed"
        if(class(xml.status)[1]=="try-error"){
          warn.msg=sprintf(warn.fmt.xml, pathway.id[i])
          message("Warning: ", warn.msg)
          unlink(xml.target)
        }
      }
    }
    
    if("png" %in% file.type){
      for (i in 1:npath) {
        msg=sprintf("Downloading png files for %s, %d/%d pathways..", pathway.id[i], i, length(pathway.id))
        message("Info: ", msg)
        png.url=sprintf(png.fmt,  pathway.id[i])#species[i], png.fnames[i])
        png.target=sprintf("%s/%s", kegg.dir, png.fnames[i])
        png.status=suppressWarnings(try(download.file(png.url, png.target, quiet=T, mode="wb"), silent=T))

        if(png.status!=0) all.status[i]="failed"
        if(class(png.status)[1]=="try-error"){
          warn.msg=sprintf(warn.fmt.png, pathway.id[i])
          message("Warning: ", warn.msg)
          unlink(png.target)
        }
      }
    }

    return(all.status)
  }

