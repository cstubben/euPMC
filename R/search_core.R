#' Search Europe PMC core and get article citations and MeSH terms

search_core <- function(query, page, limit=1000){

   query <- gsub(" ", "+", query)
   url   <- paste0("http://www.ebi.ac.uk/europepmc/webservices/rest/search/query=", query)
   url <- paste0(url, "&resulttype=core") 
   url <- paste0(url, "&pageSize=", limit)
   if(!missing(page)) url <- paste0(url, "&page=", page)
   url <- URLencode( url )   

   doc   <- xmlParse( suppressWarnings( readLines(url)))

   n    <- xpathSApply(doc, "//hitCount", xmlValue)
   if(n==1){
       message("1 Result")
   }else{
       message(n, " Results")
   }

   if(n == 0){
      NULL
   }else{
  
      x <- getNodeSet(doc, "//result")
      pmid <-   as.numeric( sapply(x, xpath2, "./pmid"))
      a1 <-    sapply(x, xpath2, "./authorString")
      authors <- authors_etal(a1)
      year <-   as.numeric( sapply(x, xpath2, "./pubYear"))
      title <- sapply(x, xpath2, "./title")
      title <- gsub("\\.$", "", title)
      # journal citations
      ta <- sapply(x, xpath2, ".//medlineAbbreviation")
      volume <- sapply(x, xpath2, "./journalInfo/volume")
      issue <- sapply(x, xpath2, "./journalInfo/issue")
      pages <- sapply(x, xpath2, "./pageInfo")

      journal <- ifelse( is.na(issue), paste(ta, " ", volume, ":", pages, sep =""),
                                       paste(ta, " ", volume, "(", issue, "):", pages, sep =""))
      journal <- gsub(":NA$", "", journal )  # missing pages


      citedBy <- sapply(x, xpath2, "./citedByCount")
      published <- sapply(x, xpath2, "./firstPublicationDate")
      doi <- sapply(x, xpath2, "./doi")

      mesh <- sapply(x, mesh2)
      # keep ta for matching to nlm
      y <- data.frame( pmid, authors, year, title, journal, citedBy, published, doi, ta, mesh, stringsAsFactors=FALSE)

   }
}

## FUNCTIONS TO parse result node set

xpath2 <-function(Node, path){
     y <- xpathSApply(Node, path, xmlValue)
     ifelse(length(y)==0, NA, 
        ifelse(length(y)>1, paste(y, collapse="; "), y))
}

## get mesh descriptor and qualifier
mesh2 <-function(Node){

  # Get descriptors and qualifiers
   mesh <- xpathSApply(Node, ".//meshHeading/descriptorName|.//meshHeading//qualifierName", xmlValue)
 if(length(mesh)>0){
  # Mark terms that are major topics of the article  with an asterisk 
   topic <-  xpathSApply(Node, ".//meshHeading//majorTopic_YN", xmlValue)
   topic <- ifelse(topic=="Y", "*", "")
   # paste * to mesh term
   mesh <- paste0(mesh, topic)

   ## Paste "/" before qualifier names
   qual  <-xpathSApply(Node,  ".//meshHeading/descriptorName|.//meshHeading//qualifierName", xmlName)
   qual <- ifelse( qual =="qualifierName", "/", "")
  mesh <- paste0(qual, mesh)

   #merge descriptor and qualifier# SEE http://stackoverflow.com/questions/38364060/paste-some-elements-of-mixed-vector

   mesh <- as.vector(unlist(tapply(mesh, cumsum(!grepl("^/", mesh)), function(x) paste0(x[1], x[-1]))))
   }else{
     mesh<- NA
  }
   paste(mesh, collapse="; ")
}

