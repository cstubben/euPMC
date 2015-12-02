authors_etal <- function(x, authors=3, split=", "){
   if(is.data.frame(x)) x <- x$authorString
   y <- strsplit(x, split)
   sapply(y, function(x){
      if(length(x) > (authors + 1))  x <- c(x[1:authors], "et al.")
      paste(x, collapse=split)
   })
}

 
