#' Format author strings
#'
#' Format delimited lists of authors and replace others with et al.
#'
#' Replaces 2 or more authors with et al.
#'
#' @param x A vector of author names
#' @param authors Number of authors to display before adding et al.
#' @param split Character used for splitting author strings, default comma
#'
#' @return a vector
#'
#' @author Chris Stubben
#'
#' @examples
#' authors_etal("Kawasaki S, Mizuguchi K,Sato M, Kono T, Shimizu H.")
#' authors_etal("Kawasaki S, Mizuguchi K,Sato M, Kono T, Shimizu H.", 2)
#' @export

authors_etal <- function(x, authors=3, split=", *"){
   y <- strsplit(x, split)
   sapply(y, function(x){
      if(length(x) > (authors + 1))  x <- c(x[1:authors], "et al.")
      paste(x, collapse=", ")
   })
}
