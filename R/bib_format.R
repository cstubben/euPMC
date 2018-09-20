#' Format a bibliography
#'
#' Format Europe PMC search results into a bibliography
#'
#' @param x epmc_search results
#' @param authors Number of authors to display before adding et al.
#' @param issue Include issue number with citation
#' @param links Add Markdown links to Journal, Cited by counts and PubMed ID, default FALSE
#' @param cited Include Cited By:<count>
#' @param pmid Include PubMed:<ID>
#' @param number Number references in bibliography
#'
#' @return a vector
#' @note Currently, the references are formatted using author, year, title and journal
#' @author Chris Stubben
#' @seealso \code{\link{strwrap}} for formatting
#' @examples
#' data(yp)
#' bib_format(yp[1:5,])
#' cat(strwrap(bib_format(yp[1:5,], number=TRUE, pmid=TRUE), exdent=3), sep="\n")
#' @export

bib_format <- function(x, authors=3, issue=TRUE, links=FALSE, cited=FALSE, pmid=FALSE, number=FALSE){
    n1 <- grep("^author", names(x) )  #authorString or authors
    authors <- authors_etal( x[[n1]], authors=authors)
    #combine journal volume issue pages
    journal <- journal_cite(x, issue=issue)


   n1 <- grep("pubYear|year", names(x) )  #pubYear or year
    year <- x[[n1]]
    n1 <- grep("^title", names(x) )
    title <- x[[n1]]

    n1 <- grep("cited", names(x) )
    citedBy <- x[[n1]]

   # Markdown links
   if(links){
       citedBy <- ifelse(citedBy == 0, 0,
                 paste('[', citedBy, '](https://europepmc.org/search?query=cites%3A', x$pmid, '_MED)', sep=""))
       x$pmid <- paste0('[', x$pmid, '](https://europepmc.org/abstract/MED/', x$pmid, ')' )
      journal <-  ifelse(is.na(x$doi), journal, paste0('[', journal, '](https://doi.org/', x$doi, ')') )
   }
    ## ADD additional formats as option?
    y <-  paste0(authors, " ", year, ". ", title, " ", journal)

    #  year in parentheses or journal in Markdown italics
     # y <-  paste0(authors, " (", year, "). ", title, " ", journal, ".")
    #  y <-  paste0(authors, " ", year, ". ",   title, " *", journal, "*.")

   if(cited) y <- paste0(y, " Cited By:", citedBy)
   if(pmid)  y <- paste0(y, " PubMed:", x$pmid)
   if(number){
       n1 <- sprintf(paste0("%", nchar(length(y)), "s"), 1:length(y) )
       y <- paste(n1, y, sep=". ")
   }
   y
}
