pathview.stamp <-
function(x=NULL, y=NULL, position="bottomright", graph.sizes, on.kegg=TRUE, cex=1){
if(on.kegg)    labels ="Data on KEGG graph\nRendered by Pathview"
else labels="-Data with KEGG pathway-\n-Rendered  by  Pathview-"
if(is.null(x)| is.null(y)){
  x=graph.sizes[1]*.80
  y=graph.sizes[2]/40
  if(length(grep('left',position))==1)  x=graph.sizes[1]/40
  if(length(grep('top', position))==1)  y=graph.sizes[2]-y
}
text(x=x, y=y, labels=labels, adj=0, cex = cex, font=2)
}

