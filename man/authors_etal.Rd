\name{authors_etal}
\alias{authors_etal}
\title{ Format author strings }
\description{ Format long lists of authors and replace others with et al.  }
\usage{
authors_etal(x, authors = 3, split = ", ")
}

\arguments{
  \item{x}{ A vector of author strings, or a data.frame with an authorString column}
  \item{authors}{  Number of authors to display before adding et al. }
  \item{split}{  Character used for splitting author strings }
}
\details{  Replaces 2 or more authors with et al.  }
\value{ a vector }
%\references{ }
\author{ Chris Stubben }
%\note{ }
%\seealso{}
\examples{
authors_etal("Kawasaki S, Mizuguchi K, Sato M, Kono T, Shimizu H.")
authors_etal("Kawasaki S, Mizuguchi K, Sato M, Kono T, Shimizu H.", 2)
data(yp)
authors_etal(yp[1:10,] )

}
\keyword{ methods }

