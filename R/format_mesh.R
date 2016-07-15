#' Format a summary table of semi-colon delimited mesh terms 
#' (with major topics marked by *)


format_mesh<-function( x){
   if(is.data.frame(x)) x<- x$mesh

   y <- unlist( strsplit(x, "; "))
   y<- y[y!="NA"]
if(length(y)==0){
   y<-NA
}else{
   z<- ifelse(grepl("\\*", y), "Major", "Total")
   y <- gsub("\\*", "", y)
   y <- as.data.frame.matrix( table(y,z) )

   y$Total <- y$Major+ y$Total
   y <- y[order(y$Major, y$Total, decreasing=TRUE),]

   y <- data.frame(MeSH = rownames(y), y, stringsAsFactors=FALSE)
   rownames(y) <- NULL
   y[order(y$Major, y$Total, decreasing=TRUE),]
}
y

}

