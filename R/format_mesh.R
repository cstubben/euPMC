#' Format MeSH terms
#'
#' Format a summary table of semi-colon delimited MeSH terms
#' (with major topics marked by *)
#'
#' @param x a vector of MeSH terms
#'
#' @return a tibble
#'
#' @author Chris Stubben
#'
#' @examples
#' data(yp)
#' format_mesh(yp)
#' @export

format_mesh<-function( x){
   if(is.data.frame(x)) x<- x$mesh
   y <- unlist( strsplit(x, "; "))
   y<- y[y!="NA"]
   if(length(y) == 0){
      y <- data.frame(MeSH="No MeSH terms assigned")
   }else{
      z <- ifelse(grepl("\\*", y), "Major", "Total")
      y <- gsub("\\*", "", y)
      y <- as.data.frame.matrix( table(y,z) )
      y$Total <- y$Major+ y$Total
      y <- y[order(y$Major, y$Total, decreasing=TRUE),]
      y <- data.frame(MeSH = rownames(y), y, stringsAsFactors=FALSE)
      rownames(y) <- NULL
      y[order(y$Major, y$Total, decreasing=TRUE),]
   }
   dplyr::tbl_df(y)
}
