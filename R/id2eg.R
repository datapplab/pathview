id2eg <-function(ids, category=gene.idtype.list[1], org="Hs", pkg.name=NULL, ...){
  category=tolower(category)
  if(category %in% c("entrez", "eg", "entrezid")) stop("input ID or category is already Entrez Gene ID!")
  geneannot.map(in.ids=ids, in.type=category, out.type="entrez", org=org, pkg.name=pkg.name, ...)
}
