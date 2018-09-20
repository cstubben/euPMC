#' Format a Javascript DataTable
#'
#' Format a data.frame to display using datatable in the DT library
#'
#' @param x Europe PMC search results
#' @param authors Number of authors to display before adding et al.
#' @param issue Include issue number with journal citation
#' @param links Add html links to PubMed ID, Journal, and Cited by counts, default TRUE
#'
#' @return a data.frame with pmid, authors, year, title, journal and cited by counts
#' @note Requires the \code{DT} package for displaying tables
#' @author Chris Stubben
#'
#' @examples
#' data(yp)
#' DT_format(yp[6:8,])
#' \dontrun{
#' x1 <- DT_format(yp)
#' library(DT)
#' datatable(x1, escape = c(1,5) , caption= "Publications with Yersinia pestis virulence in title")
#' }
#' @export

DT_format <- function(x, authors=3, issue=FALSE, links=TRUE ){
   n1 <- grep("^author", names(x) )  #authorString or authors
   authors <- authors_etal( x[[n1]], authors=authors)
   n1 <- grep("pubYear|year", names(x) )  #pubYear or year
   year <- x[[n1]]
   n1 <- grep("^title", names(x) )
   title <- x[[n1]]
   #combine journal volume pages
   journal <- journal_cite(x, issue=issue)
   n1 <- grep("cited", names(x) )
   citedBy <- x[[n1]]
   pmid <- x$pmid
   # hyperlinks
   if(links){
       citedBy <- ifelse(citedBy == 0, 0, paste('<a href="https://europepmc.org/search?query=cites%3A',
                                           x$pmid, '_MED" target="_blank">', citedBy,  '</a>', sep=""))
       pmid <- paste0('<a href="https://europepmc.org/abstract/MED/', pmid, '" target="_blank">', pmid,  '</a>')
    # some dois missing
    journal <-  ifelse(is.na(x$doi), journal, paste0('<a href="https://doi.org/', x$doi, '" target="_blank">', journal,  '</a>') )
   }
   x <- data.frame( pmid, authors, year, title, journal, citedBy)
   x
}
