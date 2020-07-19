parseKGML2Graph2 <-function (file, ...)
  {
    pathway <- parseKGML2(file)
    gR <- KEGGpathway2Graph2(pathway, ...)
    return(gR)
  }
