\name{yp}
\alias{yp}
\docType{data}
\title{ Yersinia pestis virulence publications }
\description{ Europe PMC search results with Yersinia pestis virulence in title }
\usage{ data(yp) }
\format{
  A data frame with 156 observations on the following 12 variables.
  \describe{
    \item{\code{pmid}}{a PubMed ID}
    \item{\code{authorString}}{ authors }
    \item{\code{pubYear}}{ year }
    \item{\code{title}}{ title }
    \item{\code{journalTitle}}{ journal }
    \item{\code{journalVolume}}{ volume }
    \item{\code{issue}}{ issue }
    \item{\code{pageInfo}}{ pages }
    \item{\code{citedByCount}}{ cited by counts }
    \item{\code{pmcid}}{ PMC ID}
    \item{\code{DOI}}{ DOI }
    \item{\code{pubType}}{ publication type }
  }
}
\details{ The XML tag names are used as column names }
\source{  Europe PMC search }

\examples{
data(yp)
\dontrun{ yp <- search_lite("title:(Yersinia pestis virulence)")}
t(yp[7,])
bib_format(yp[1:7,])
data.frame(n=sort(table(unlist(strsplit(yp$pubType, "; "))), decreasing=TRUE))
subset(yp, grepl("retracted", pubType))
data.frame(n=sort(table(unlist(strsplit(yp$authorString, ", "))), decreasing=TRUE)[1:15])
}
\keyword{datasets}