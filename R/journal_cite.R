journal_cite <- function( x, issue=TRUE){
   n <- match(c("journalTitle", "journalVolume", "issue", "pageInfo"), names(x))
   if(issue){
      y <- paste(x[,n[1]], " ", x[,n[2]], "(", x[,n[3]], "):", x[,n[4]], sep ="")
      y <- gsub("(NA)", "", y, fixed=TRUE)  # missing issue
  }else{
      y <- paste(x[,n[1]], " ", x[,n[2]], ":", x[,n[4]], sep ="")
   }
   y <- gsub(":NA$", "", y )  # missing pages
    y <- gsub(" NA", " ", y )  # missing journal?
   y
}





