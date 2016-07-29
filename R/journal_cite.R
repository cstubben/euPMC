#' Format journal citations
#'
#' Format journal title, volume, issue and pages into single string
#'
#' Formats citations with or without the issue number like MBio 5(1):13  or MBio 5:13
#'
#' @param x a data.frame with output from \code{epmc_search}
#' @param n a vector with 4 columns positions for journal, volume, issue and page,
#'         will match \code{epmc_search} output by default
#' @param issue include issue with citation, default TRUE
#'
#' @return a vector
#'
#' @author Chris Stubben
#'
#' @examples
#' data(yp)
#' journal_cite(yp[1:5,])
#' journal_cite(yp[1:5,], issue=FALSE)
#' @export

journal_cite <- function( x, n, issue=TRUE){
   if(missing(n))
   {
      # search_core output
      n <- pmatch(c("nlm_ta", "volume", "issue", "page"), names(x))
      if(any(is.na(n))){  # epmc_search from europepmc
         n <- pmatch(c("journalTitle", "journalVolume", "issue", "page"), names(x))
      }
      if( any(is.na(n))) stop("Cannot match journal, volume, issue, page columns")
   }

   if(issue){
      y <- apply(x[,n], 1, function(y) paste(y[1], " ", y[2], "(", y[3], "):", y[4], sep ="") )
      y <- gsub("(NA)", "", y, fixed=TRUE)  # missing issue
   }else{
      y <- apply(x[,n], 1, function(y) paste(y[1], " ", y[2], ":", y[4], sep ="") )
   }
   y <- gsub(":NA$", "", y )  # missing pages
   y <- gsub(" NA", " ", y )  # missing journal?
   y
}
