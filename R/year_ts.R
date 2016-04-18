year_ts <- function(x, start, end, sum=FALSE){
    y <- x$pubYear
    y <- as.numeric(y)
   if(missing(start))  start <- min(y) 
   if(missing(end))  end <- format(Sys.Date(), "%Y")
   y <- factor(y, start:end)
   y <- table(y)
   if(sum) y <- cumsum(y)
   z <- ts(as.vector(y), start= start )
   z
}
