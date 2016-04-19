\name{nlm}
\alias{nlm}
\docType{data}
\title{ Journals currently or previously indexed in MEDLINE  }
\description{
  Titles, abbreviations, MeSH terms and other details of journals currently or previously indexed in the NLM Catalog at NCBI
}
\usage{data("nlm")}
\format{
  A data frame with 14982 observations on the following 7 variables.
  \describe{
    \item{\code{ta}}{ title abbreviation = MedlineTA tag}
    \item{\code{title}}{ journal title = TitleMain/Title tag}
    \item{\code{country}}{ country = Country tag}
    \item{\code{language}}{ primary language = Language[@LangType="Primary"] tag }
    \item{\code{year}}{ first publication year = PublicationFirstYear tag }
    \item{\code{mesh}}{ MeSH terms = MeshHeading/DescriptorName tags } 
    \item{\code{current}}{ Currently indexed in MEDLINE = IndexingSourceName[@IndexingStatus="Currently-indexed"] tag matches MEDLINE }

  }
}
\details{ XML search results from the NLM Catalog at NCBI using "reportedmedline" on April 18, 2015 }
\source{
\url{http://www.ncbi.nlm.nih.gov/nlmcatalog}
}
%\references{ }
\examples{
data(nlm)
table(nlm$current)
subset(nlm, grepl("Heart Diseases", mesh) )
table2(unlist(strsplit(nlm$mesh, "; ")))
}
\keyword{datasets}
