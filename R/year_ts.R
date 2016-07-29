#' Publication year time series
#'
#' Create a time-series object from publication years
#'
#' @param x a vector of years, or optionally epmc_search results
#' @param start year of first observation, default minimum year in series
#' @param end year of last observation, default today's year
#' @param sum return cumulative sum
#'
#' @return a time-series object
#' @seealso \code{\link{ts}}
#' @author Chris Stubben
#'
#' @examples
#' data(yp)
#' y <- year_ts(yp)
#' plot(y, xlab="Year published", ylab="Articles per year", las=1,
#'     main="Publications with Yersinia pestis virulence in title")
#' @export

year_ts <- function(x, start, end, sum=FALSE){
    if(is.data.frame(x)){
       n1 <- grep("pubYear|year", names(x) )  #pubYear or year
       x <- x[[n1]]
    }
    y <- as.numeric(x)
    if(length(y)==0) stop("No pub years found")
   if(missing(start))  start <- min(y)
   if(missing(end))  end <- format(Sys.Date(), "%Y")
   y <- factor(y, start:end)
   y <- table(y)
   if(sum) y <- cumsum(y)
   z <- stats::ts(as.vector(y), start= start )
   z
}
