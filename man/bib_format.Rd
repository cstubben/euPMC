\name{bib_format}
\alias{bib_format}
\title{ Format a bibliography }
\description{ Format Europe PMC search results into a bibliography  }
\usage{
bib_format(x, authors = 3, issue = TRUE, links = FALSE, cited = FALSE, pmid = FALSE, number = FALSE)
}
\arguments{
  \item{x}{ Europe PMC search results }
  \item{authors}{ Number of authors to display before adding et al. }
  \item{issue}{ Include issue number with citation }
  \item{links}{ Add Markdown links to Journal, Cited by counts and PubMed ID, default FALSE }
  \item{cited}{ Include Cited By:<count>  }
  \item{pmid}{ Include PubMed:<ID> }
  \item{number}{ Number references in bibliography }
}
%\details{ }
\value{  a vector }
%\references{  }
\author{ Chris Stubben }
\note{ Currently, the references are formatted using author, year, title and journal format,
which is easy to edit within the function. 
}

\seealso{ \code{strwrap } for formatting  }
\examples{
data(yp)
bib_format(yp[1:5,])
cat(strwrap(bib_format(yp[1:5,], number=TRUE, pmid=TRUE), exdent=3), sep="\n")
}
\keyword{ methods }