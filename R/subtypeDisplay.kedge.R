utils::globalVariables("KEGGEdgeSubtype")

subtypeDisplay.kedge <-
function (object, ...) 
{
  .local <- function (object) 
    {
      subtypes <- getSubtype(object)
      if (length(subtypes) == 1) {
        display <- subtypeDisplay(subtypes[[1]])
      }
      else if(length(subtypes) > 1){
        display.matrix <- sapply(subtypes, subtypeDisplay)
        display <- display.matrix[,1]
        display[c("name","value")] <- apply(display.matrix[c("name","value"), ], 1, paste, collapse = ",")
        dlabel=display.matrix["label", ]
        display["label"] <- paste(dlabel[dlabel>""], collapse = ",")
      } else{
        etype=getType(object)
        if(etype=="PCrel"){
          st.uk=new("KEGGEdgeSubType", name = "compound", value = "unknown")
        } else{
          message("Info: ", paste("Edge type:", etype, "without subtype sepecified!"))
          st.uk=new("KEGGEdgeSubType", name = "unknown", value = "unknown")
        }
        display <- subtypeDisplay(st.uk)
      }
      return(display)
    }
  .local(object, ...)
}

setMethod("subtypeDisplay", signature(object = "KEGGEdge"), subtypeDisplay.kedge)
