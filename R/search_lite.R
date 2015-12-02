search_lite <- function(query, page, pageSize=1000, src=TRUE, drop = TRUE){
   if(src) query <- paste0("(", query, ") AND SRC:MED")
   query <- gsub(" ", "%20", query)  
   url   <- paste0("http://www.ebi.ac.uk/europepmc/webservices/rest/search/query=", query)
    url <- paste0(url, "&resulttype=lite") 
   url <- paste0(url, "&pageSize=", pageSize)
   if(!missing(page)) url <- paste0(url, "&page=", page)
   doc   <- xmlParse( suppressWarnings( readLines(url)))
   n     <- xpathSApply(doc, "//hitCount", xmlValue)
   message(n, " Results")
   if(n == 0){
      NULL
   }else{
      x <- xmlToDataFrame(doc["//result"], stringsAsFactors = FALSE)
      if(drop){
         ####   Some tags  may be missing in XML
         x1 <- c("pmid", "authorString", "pubYear", "title" , "journalTitle", "journalVolume", "issue", "pageInfo",  "citedByCount", "pmcid", "DOI", "pubType")
         n <- match(x1, names(x))
         n2 <- which(is.na(n))
         if(length(n2) > 0){   
             for (j in x1[n2]){
                 message(" Adding missing column: ", j)
                 x[[ j ]] <- NA_character_
             }
            n <- match(x1, names(x))
         }
         x <- x[,n]
         ######
         x$pmid       <- suppressWarnings(as.numeric(x$pmid) ) # may be missing if src=FALSE
         x$pubYear    <- as.numeric(x$pubYear) 
         x$citedByCount <- as.numeric(x$citedByCount)
         ## sort by pmid?
         x <- x[order(x$pmid, decreasing=TRUE),]
         rownames(x) <- NULL
     }
      attr(x, "query") <- query
      attr(x, "date") <- Sys.Date()
      x
   }
}


