table2<- function(x){
  x[x==""] <- NA
  y <- sort(table(x), decreasing=TRUE)
  z <- data.frame(name=names(y), n=as.vector(y), stringsAsFactors=FALSE)
  dplyr::tbl_df(z)
}
