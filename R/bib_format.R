bib_format <- function(x, authors=3, issue=TRUE, links=FALSE, cited=FALSE, pmid=FALSE, number=FALSE){
    authors <- authors_etal( x$authorString, authors=authors)
    #combine journal volume issue pages
   if(issue){
       journal <- journal_cite(x)
   }else{
       journal <- journal_cite(x, FALSE)
   }
    year <- x$pubYear
    title <- x$title
    
   # Markdown links
   if(links){
       x$citedByCount <- ifelse(x$citedByCount == 0, 0,
                 paste('[', x$citedByCount, '](http://europepmc.org/search?query=cites%3A', x$pmid, '_MED)', sep=""))
      x$pmid <- paste0('[', x$pmid, '](http://europepmc.org/abstract/MED/', x$pmid, ')' )
      journal <-  ifelse(is.na(x$DOI), journal, paste0('[', journal, '](http://dx.DOI.org/', x$DOI, ')') ) 
   }
    ## ADD additional formats as option?
    y <-  paste0(authors, " ", year, ". ", title, " ", journal, ".")
    #  year in parentheses or journal in Markdown italics
     # y <-  paste0(authors, " (", year, "). ", title, " ", journal, ".")
    #  y <-  paste0(authors, " ", year, ". ",   title, " *", journal, "*.")

   if(cited) y <- paste0(y, " Cited By:", x$citedByCount)
   if(pmid)  y <- paste0(y, " PubMed:", x$pmid) 
   if(number){
       n1 <- sprintf(paste0("%", nchar(length(y)), "s"), 1:length(y) )
       y <- paste(n1, y, sep=". ")
   }
   y
}

