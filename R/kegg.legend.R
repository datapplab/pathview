utils::globalVariables("KEGGEdgeSubtype")

kegg.legend=function (type=c("both", "edge", "node")[1]) {
  if(!type %in% c("both", "edge", "node")){
    msg.fmt="type has to be one of: \"%s\", \"%s\" and \"%s\"!"
    msg=sprintf(msg.fmt, "both", "edge", "node")
    message("Note: ", msg)
    return(invisible(0))
  }
#  if (!exists("KEGGEdgeSubtype")) {
#    data(KEGGEdgeSubtype)
#  }
  KEGGEdgeSubtype <- KEGGEdgeSubtype[-7,]
  levels(KEGGEdgeSubtype$name)[13]="others/unknown"
  subtypes <- KEGGEdgeSubtype$name
  cols <- as.character(KEGGEdgeSubtype$color)
  labels <- as.character(KEGGEdgeSubtype$label)
  fontcolors <- as.character(KEGGEdgeSubtype$fontcolor)
  arrowheads <- as.character(KEGGEdgeSubtype$arrowhead)
  styles <- as.character(KEGGEdgeSubtype$style)
  ltytrans <- c(solid = 1, dashed = 2, dotted = 3)
  ltys <- ltytrans[styles]
  nst=nrow(KEGGEdgeSubtype)

  if(type=="edge"){
    top.margin=2
    xlim=c(-0.4,1.8)
    ylim=c(0, nst)
    main.txt="Edge types"
  } else if(type=="node"){
    top.margin=2
    xlim=c(-0.4,1.8)
    ylim=c(0, nst)
    main.txt="Node types"
    ntext.x=0.7
    xs=1.3
  } else {
    top.margin=3
    xlim=c(-0.2,4.0)
    ylim=c(0, nst+1)
    main.txt="KEGG diagram legend"
    ntext.x=3.1
    xs=3.7  
  }
  opar <- par(mar = c(0, 0, top.margin, 0), mgp = c(0, 0, 0), lwd=2)
  on.exit(par(opar))

  plot(1, 1, type = "n", xlim = xlim, ylim = ylim,
       axes = FALSE, xlab = "", ylab = "", main = main.txt)
  if(type %in% c("both","edge")){
    for (i in 1:nst) {
      j=nst-i
      text(0.8, j, subtypes[i], pos = 2, cex = 1.2)
      segments(1, j, 1.8, j, col = cols[i], lty = ltys[i])
      text(1.4, j+.2, labels[i], col = fontcolors[i])
      if (arrowheads[i] == "normal") {
        x=c(1.77,1.77,1.8)
        h=0.15/cos(pi/6)
        y=c(h,-h,0)+j
        polygon(x,y,col=cols[i], border=cols[i], lwd=1)
      }
      if (arrowheads[i] == "open") {
        x=c(1.78,1.78,1.8)
        h=0.1/cos(pi/6)
        y=c(h,-h,0)+j
        polygon(x,y,col=cols[i], border=cols[i], lwd=1)
      }
      if (arrowheads[i] == "tee") {
        lines(c(1.8,1.8), c(.3,-.3)+j, col = cols[i], lwd=3)
      }
    }
  }
  
  if(type %in% c("both","node")){
    ntypes=c("gene", "group", "compound", "map")
    naliases=c("protein/enzyme", "complex", "metabolite/glycan", "pathway")
    nshapes=c("rectangle", "rectangle group", "ellipse", "plaintext")
    node.types=data.frame(types=ntypes, aliases=naliases, shapes=nshapes, width=rep(46,4), height=rep(17,4))

                                        #  if(!edges.only){
    ntypes=as.character(node.types$types)
    naliases=as.character(node.types$aliases)
    nlabels=paste(ntypes, "\n(", naliases, ")", sep="")
    nshapes=as.character(node.types$shapes)
    nwidth=node.types$width/250
    nheight=node.types$height/250
    nnt=nrow(node.types)
    for (i in 1:nnt) {
      j=nst-i*3
      text(ntext.x, j, nlabels[i], pos = 2, cex = 1.2)
    }
    ys=nst-(1:4)*3
    rect.x1=rep(xs-nwidth,4)
    rect.x2=rep(xs+nwidth,4)
    rect.y1=rep(ys[1:2],c(1,3))-nheight[1:2]*c(1,2,0,2)*6
    rect.y2=rep(ys[1:2],c(1,3))+nheight[1:2]*c(1,2,2,0)*6
    rect(rect.x1,rect.y1,rect.x2,rect.y2)
    ellipses(xs,ys[3],nwidth[3],nheight[3]*6, cols=NULL)
    text(xs, ys[4], "Pathway name", cex = 1.2)
    if(type!="node"){
      text(1.0, nst+1, "Edge Types", cex = 1.2, font=2)
      text(3.0, nst+1, "Node Types", cex = 1.2, font=2)
    }
  }
}
