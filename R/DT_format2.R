#' Format search_core output 


DT_format2 <- function(x, links=TRUE ){

   # hyperlinks
   if(links){
       x$citedBy <- ifelse(x$citedBy == 0, 0, paste('<a href="http://europepmc.org/search?query=cites%3A', x$pmid, '_MED" target="_blank">', x$citedBy,  '</a>', sep=""))
       x$pmid <- paste0('<a href="http://europepmc.org/abstract/MED/', x$pmid, '" target="_blank">', x$pmid,  '</a>')
  # some dois missing
    x$journal <-  ifelse(is.na(x$doi), x$journal, paste0('<a href="http://dx.doi.org/', x$doi, '" target="_blank">', x$journal,  '</a>') )
      
   }
   x <- x[,c("pmid", "authors", "year", "title", "journal", "citedBy")]
   x
}



