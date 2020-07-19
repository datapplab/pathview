parseReaction2 <-
function (reaction)
  {
    attrs <- xmlAttrs(reaction)
    name <- attrs[["name"]]
    type <- attrs[["type"]]
    children <- xmlChildren(reaction)
    childrenNames <- names(children)
    substrateIndices <- grep("^substrate$", childrenNames)
    productIndices <- grep("^product$", childrenNames)
    substrateName <- substrateAltName <- vector("character",
                                                length(substrateIndices))
    productName <- productAltName <- vector("character", length(productIndices))
    for (i in seq(along = substrateIndices)) {
      ind <- substrateIndices[i]
      substrate <- children[[ind]]
      substrateName[i] <- xmlAttrs(substrate)[["id"]]
      substrateChildren <- xmlChildren(substrate)
      if (length(substrateChildren) > 0) {
        substrateAlt <- substrateChildren$alt
        substrateAltName[i] <- xmlAttrs(substrateAlt)[["name"]]
      }
      else {
        substrateAlt <- as.character(NA)
        substrateAltName[i] <- as.character(NA)
      }
    }
    for (i in seq(along = productIndices)) {
      ind <- productIndices[i]
      product <- children[[ind]]
      productName[i] <- xmlAttrs(product)[["id"]]
      productChildren <- xmlChildren(product)
      if (length(productChildren) > 0) {
        productAlt <- productChildren$alt
        productAltName[i] <- xmlAttrs(productAlt)[["name"]]
      }
      else {
        productAlt <- as.character(NA)
        productAltName[i] <- as.character(NA)
      }
    }
    new("KEGGReaction", name = name, type = type, substrateName = substrateName,
        substrateAltName = substrateAltName, productName = productName,
        productAltName = productAltName)
  }

