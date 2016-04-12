\name{year_ts}
\alias{year_ts}
\title{  Publication year time series }
\description{ Create a time-series object from publication years }
\usage{ year_ts(x, start, end)  }
\arguments{
  \item{x}{ a vector of years, or optionally PMC search results with pubYear}
  \item{start}{ year of first observation, default minimum year in series }
  \item{end}{  year of last observation, default today's year  }
}
%\details{  }
\value{ a time-series object }
%\references{ }
\author{  Chris Stubben }
%\note{ }
\seealso{  \code{\link{ts}} }
\examples{
data(yp)
y <- year_ts(yp)
plot(y, xlab="Year published", ylab="Articles per year", las=1, main="Publications with Yersinia pestis virulence in title")
}
\keyword{ methods }
