\name{search_lite}
\alias{search_lite}
\title{ Search the Europe PubMed Central }
\description{  Search the Europe PMC Rest Service and parse the lite XML resulttype  }
\usage{
search_lite(query, page, limit = 1000, src = TRUE, drop = TRUE)
}
\arguments{
  \item{query}{ a valid query string }
  \item{page}{ results page, default 1}
  \item{limit}{ number of articles, default is maximum allowable 1000 }
  \item{src}{ add SRC:MED to query to return articles with Pubmed IDs  }  
  \item{drop}{ Drop hasBook, hasPDF and other logical "Y" or "N" columns, see details  }
}
\details{ Download XML lite results and convert to a data.frame and if drop=TRUE,
return 12 columns (even if tags are missing) with metadata for reference lists
instead of 15 or more additional columns with "Y" or "N" links to other datasets.
}
\value{ A data.frame with search results.  The query and date are added as attributes }
\references{ \url{http://europepmc.org/RestfulWebService#search}  }
\author{ Chris Stubben}
\note{ Search fields are listed at \url{https://europepmc.org/Help#fieldsearch}  }
%\seealso{ \code{\link{search_core}}  }
\examples{
\dontrun{
search_lite("Yersinia pestis hmsB")
search_lite("cites:1649616_MED")
# yp included in package
yp <- search_lite("title:(Yersinia pestis virulence)")
}
}
\keyword{ methods }
