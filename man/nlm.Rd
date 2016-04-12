\name{nlm}
\alias{nlm}
\docType{data}
\title{ Journals currently indexed in the NLM Catalog at NCBI }
\description{
  Titles, abbreviations, MeSH terms, access and other details of journals currently indexed in the NLM Catalog 
}
\usage{data("nlm")}
\format{
  A data frame with 5631 observations on the following 8 variables.
  \describe{
    \item{\code{ta}}{ title abbreviation}
    \item{\code{title}}{ journal title}
    \item{\code{country}}{ country}
    \item{\code{language}}{ primary language}
    \item{\code{year}}{ first publication year}
    \item{\code{mesh}}{ MeSH terms}
    \item{\code{free}}{ Free to read in PMC }
    \item{\code{open}}{ Open access in PMC }
  }
}
\details{ Search results from the NLM Catalog at NCBI using "currentlyindexed" on April 12, 2015.  
Free and open access columns were added from the PMC Journal List at Europe PMC \url{http://europepmc.org/journalList}
}
\source{
\url{http://www.ncbi.nlm.nih.gov/nlmcatalog}
}
%\references{ }
\examples{
data(nlm)
table(nlm$open)
subset(nlm, grepl("Heart Diseases", mesh) , 2:5)

}
\keyword{datasets}
