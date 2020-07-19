eg2id <-function(eg, category=gene.idtype.list[1:2], org="Hs", pkg.name=NULL, ...){
  category=tolower(category)
  ei=category %in% c("entrez", "eg", "entrezid")
  if(all(ei)) stop("output ID or category cannot all be Entrez Gene ID!")
  if(any(ei)) category=category[!ei]
  geneannot.map(in.ids=eg, in.type="entrez", out.type=category, org=org, pkg.name=pkg.name, ...)#, unique.map=TRUE, na.rm=TRUE)
}
