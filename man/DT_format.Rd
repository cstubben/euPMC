\name{DT_format}
\alias{DT_format}
\title{ Format a Javascript DataTable }
\description{ Format a data.frame to display using datatable in the DT library}
\usage{
DT_format(x, authors = 3, issue = TRUE, links = TRUE)
}
\arguments{
  \item{x}{ Europe PMC search results }
  \item{authors}{Number of authors to display before adding et al. }
  \item{issue}{ Include issue number with journal citation }
    \item{links}{ Add html links to PubMed ID, Journal, and Cited by counts, default TRUE }
}
%\details{ }
\value{ a data.frame with pmid, authors, year, title, journal and cited by counts }
%\references{ }
\author{ Chris Stubben }
\note{  Requires the \code{DT} package for displaying tables }

%\seealso{ }
\examples{
data(yp)
DT_format(yp[6:8,])
\dontrun{
x1 <- DT_format(yp)
library(DT)
datatable(x1, escape = c(1,5) , caption= "Publications with Yersinia pestis virulence in title")
}
}
\keyword{ methods }
