\name{journal_cite}
\alias{journal_cite}
\title{ Format journal citations }
\description{  Format journal title, volume, issue and pages into single string }
\usage{ journal_cite(x, issue = TRUE) }
\arguments{
  \item{x}{ a data.frame with journalTitle, journalVolume, issue, and pageInfo columns }
  \item{issue}{ include issue with citation, default TRUE  }
}
\details{ Formats citations with or without the issue number like MBio 5(1):13  or MBio 5:13 }
\value{ a vector }
%\references{ }
\author{ Chris Stubben }
%\note{ }

\examples{
data(yp)
journal_cite(yp[1:10,])
}
\keyword{ methods }

