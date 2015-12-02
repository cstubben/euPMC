DT_format <- function(x, authors=3, issue=TRUE, links=TRUE ){
   x$authorString <- authors_etal( x$authorString,  authors)
   x$title <- gsub("\\.$", "", x$title)
   #combine journal volume pages
   x$journal <- journal_cite(x, issue)

   # hyperlinks
   if(links){
       x$citedByCount <- ifelse(x$citedByCount == 0, 0, paste('<a href="http://europepmc.org/search?query=cites%3A', x$pmid, '_MED">', x$citedByCount,  '</a>', sep=""))
       x$pmid <- paste0('<a href="http://europepmc.org/abstract/MED/', x$pmid, '">', x$pmid,  '</a>')
  # some DOIs missing
    x$journal <-  ifelse(is.na(x$DOI), x$journal, paste0('<a href="http://dx.doi.org/', x$DOI, '">', x$journal,  '</a>') )
      
   }
   x <- x[,c("pmid", "authorString", "pubYear", "title", "journal", "citedByCount")]
   names(x) <- c("pmid", "authors", "year", "title", "journal", "citedBy")
   x
}



