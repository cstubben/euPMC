#' Search Europe PMC core and get article citations, abstract and MeSH terms
#'
#' Search the Europe PMC Rest Service and parse the core XML resulttype
#'
#' @param query a valid query string
#' @param page pagination options, default 1
#' @param limit number of articles, default 1000
#'
#' @return A data.frame with search results
#' @references \url{http://europepmc.org/RestfulWebService#search}
#' @author Chris Stubben
#' @note Search fields are listed at \url{https://europepmc.org/Help#fieldsearch}
#' @examples
#' search_core("Yersinia pestis hmsB")
#' @export

search_core <- function(query, page, limit=1000){

   url   <- paste0("http://www.ebi.ac.uk/europepmc/webservices/rest/search/query=", query)
   url <- paste0(url, "&resulttype=core")
   url <- paste0(url, "&pageSize=", limit)
   if(!missing(page)) url <- paste0(url, "&page=", page)
   url <- utils::URLencode( url )

 # require httr and xml2
 #   x <- GET(url)
 #   doc <- xmlParse( content( x, "text", encoding="UTF-8"))

 doc   <- XML::xmlParse( suppressWarnings( readLines(url)))

   n    <- as.numeric( XML::xpathSApply(doc, "//hitCount", XML::xmlValue))
   if(n==1){
       message("1 Result")
   }else{
       if(n < limit ){
           message(n, " Results")
       }else{
           message(n, " Results, downloading first ", limit)
       }
   }

   if(n == 0){
      NULL
   }else{

      x <- XML::getNodeSet(doc, "//result")
      pmid <-   as.numeric( sapply(x, xpath2, "./pmid"))
      pmcid <-    sapply(x, xpath2, "./pmcid")
      doi <- sapply(x, xpath2, "./doi")
      src <-    sapply(x, xpath2, "./source")
      authors <-    sapply(x, xpath2, "./authorString")
      # authors <- authors_etal(authors)
      year <-   as.numeric( sapply(x, xpath2, "./pubYear"))
      title <- sapply(x, xpath2, "./title")
      title <- gsub("\\.$", "", title)
      # journal citations
      journal <- sapply(x, xpath2, ".//journal/title")
      nlm_ta <- sapply(x, xpath2, ".//medlineAbbreviation")
      volume <- sapply(x, xpath2, "./journalInfo/volume")
      issue <- sapply(x, xpath2, "./journalInfo/issue")
      pages <- sapply(x, xpath2, "./pageInfo")

      citedby <- as.numeric(sapply(x, xpath2, "./citedByCount"))
      published <- sapply(x, xpath2, "./firstPublicationDate")
      published <- as.Date(published)

      language <- sapply(x, xpath2, "./language")
      abstract <- sapply(x, xpath2, "./abstractText")
      mesh <- sapply(x, mesh2)
      keywords <- sapply(x, xpath2, ".//keyword")
     chemicals <- sapply(x, xpath2, ".//chemical/name")
      y <- data.frame( pmid, pmcid, src, doi, authors, year, title, journal, nlm_ta,
                       volume, issue, pages,citedby, published, language, abstract,
                       mesh, keywords, chemicals, stringsAsFactors=FALSE)
      attr(y, "hit_count") <- n
      dplyr::tbl_df( y )


   }
}
