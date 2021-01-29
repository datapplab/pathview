.onLoad <- function(libname, pkgname) {
if(FALSE){
  pnames=rownames(installed.packages())
  if("pathview" %in% pnames){
    data(gene.idtype.list, package ="pathview")
    data(gene.idtype.bods, package ="pathview")
    data(cpd.simtypes, package ="pathview")
    data(korg, package ="pathview")
#    korg=try(read.delim(file="https://pathview.uncc.edu/data/korg.tsv", sep="\t"))
#    if(class(korg)[1]=="data.frame"){
#    korg$ncbi.geneid=as.character(korg$ncbi.geneid)
#    korg=as.matrix(korg)
#  } else data(korg, package ="pathview")
  }
}
disclaimer="##############################################################################\nPathview is an open source software package distributed under GNU General Public License version 3 (GPLv3). Details of GPLv3 is available at http://www.gnu.org/licenses/gpl-3.0.html. Particullary, users are required to formally cite the original Pathview paper (not just mention it) in publications or products. For details, do citation(\"pathview\") within R. \n\nThe pathview downloads and uses KEGG data. Non-academic uses may require a KEGG license agreement (details at http://www.kegg.jp/kegg/legal.html).\n##############################################################################\n\n"
packageStartupMessage(wordwrap(disclaimer, 80))
}
