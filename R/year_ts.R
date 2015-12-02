year_ts <- function(x, start, end){
   y <- x$pubYear
   if(missing(start))  start <- min(y) 
   if(missing(end))  end <- format(Sys.Date(), "%Y")
   y <- factor(y, start:end)
   y <- table(y)
   z <- ts(as.vector(y), start= start )
   z
}
