test_id2eg <- function() {
  symbs.good=c("A1BG","SERPINA3","PLIN2")
  egs.good=c("1","12","123")

  egs.mapped1=id2eg(symbs.good, category="SYMBOL", org = "Hs")[,2]
  checkEquals(egs.mapped1, egs.good)

  egs.mapped2=id2eg(c(egs.good,symbs.good), category="SYMBOL", org = "Hs")[,2]
  checkEquals(egs.mapped2, c(rep(NA,3), egs.good))

  checkException(id2eg(symbs.good, category="SYMBOL", org = "Hss"))
  checkException(id2eg(symbs.good, category="SYMBL", org = "Hs"))
}

test_eg2id <- function() {
  symbs.good=c("A1BG","SERPINA3","PLIN2")
  egs.good=c("1","12","123")

  symbs.mapped1=eg2id(egs.good, category="SYMBOL", org = "Hs")[,2]
  checkEquals(symbs.mapped1, symbs.good)

  symbs.mapped2=eg2id(c(egs.good,symbs.good), category="SYMBOL", org = "Hs")[,2]
  checkEquals(symbs.mapped2, c(symbs.good,rep(NA,3)))

  checkException(eg2id(egs.good, category="SYMBOL", org = "Hss"))
  checkException(eg2id(egs.good, category="SYMBL", org = "Hs"))
}

test_cpdidmap <- function() {
  cpd.cas=c("49620-06-6", "104206-65-7", "507-60-8", "7235-40-7",
    "17440-83-4")

#map and reverse map being consistent  
  id.map.cas <- cpdidmap(in.ids = cpd.cas, in.type = "CAS Registry Number",
                         out.type = "KEGG COMPOUND accession")
  id.map.cas2 <- cpdidmap(in.ids = id.map.cas[,2],
                          in.type = "KEGG COMPOUND accession",
                          out.type = "CAS Registry Number")
  na.idx=is.na(id.map.cas[,2])
  checkEquals(id.map.cas2[,2], cpd.cas[!na.idx])

#in.ids and in.type not matching  
  id.map.cas3 <- cpdidmap(in.ids = cpd.cas, in.type = "KEGG COMPOUND accession",
                          out.type = "CAS Registry Number")
  checkTrue(all(is.na(id.map.cas3[,2])))

#in.type and out.type are similar, no need to map  
  id.map.cas4<-cpdidmap(in.ids = cpd.cas, in.type = "KEGG COMPOUND accession",
                        out.type = "kegg")
  checkEquals(id.map.cas4, 0)

#wrong in.type, error  
  checkException(cpdidmap(in.ids = cpd.cas, in.type = "Unknown accession",
                          out.type = "kegg"))
}
