#' Journals currently or previously indexed in MEDLINE
#'
#' Titles, abbreviations, MeSH terms and other details of journals currently or
#' previously indexed in the NLM Catalog at NCBI
#'
#' XML search results from the NLM Catalog at NCBI using "reportedmedline" on April 18, 2016
#'
#' @format  A data frame with 15001 observations on the following 7 variables.
#'   \describe{
#'     \item{ta}{ title abbreviation = MedlineTA tag}
#'     \item{title}{ journal title = TitleMain/Title tag}
#'     \item{country}{ Country tag}
#'     \item{language}{ primary language = Language[@LangType="Primary"] tag }
#'     \item{year}{ PublicationFirstYear tag }
#'     \item{mesh}{ MeSH terms including descriptor, qualifier and major topic marked with * }
#'     \item{current}{ Currently indexed in MEDLINE = IndexingSourceName[@IndexingStatus="Currently-indexed"] tag matches MEDLINE }
#' }
#'
#' @source \url{http://www.ncbi.nlm.nih.gov/nlmcatalog}
#'
#' @examples
#' data(nlm)
#' table(nlm$current)
#' subset(nlm, grepl("Heart Diseases", mesh) )
#' table2(unlist(strsplit(nlm$mesh, "; ")))
#'
"nlm"

#' Yersinia pestis virulence publications
#'
#' Europe PMC core search results with Yersinia pestis virulence in title
#'
#' @format A data frame with 160 observations on the following 19 variables.
#'  \describe{
#'    \item{pmid}{PubMed ID = pmid tag}
#'    \item{pmcid}{PubMed Central ID = pmcid tag}
#'    \item{src}{ source tag }
#'    \item{doi}{ DOI tag }
#'    \item{authors}{ authorString tag }
#'    \item{year}{ pubYear tag }
#'    \item{title}{ article title tag }
#'    \item{journal}{ full journal name = journal/title tag }
#'    \item{nlm_ta}{ journal abbreviation = medlineAbbreviation tag}
#'    \item{volume}{ journalInfo/volume tag }
#'    \item{issue}{ journalInfo/issue tag }
#'    \item{pages}{ pageInfo tag }
#'    \item{citedby}{ citedByCount tag }
#'    \item{published}{ firstPublicationDate tag }
#'    \item{language}{language tag}
#'    \item{abstract}{abstractText tag}
#'    \item{mesh}{ MeSH terms including descriptor, qualifier and major topic*}
#'    \item{keywords }{keyword tags}
#'    \item{chemicals }{chemical/name tags}
#'  }
#' @source Europe PMC search
#' @examples
#' data(yp)
#' \dontrun{ yp <- search_core("title:(Yersinia pestis virulence) src:MED")}
#' t(yp[7,])
#' bib_format(yp[1:7,])
#' data.frame(n=sort(table(unlist(strsplit(yp$pubType, "; "))), decreasing=TRUE))
#' subset(yp, grepl("retracted", pubType))
#' data.frame(n=sort(table(unlist(strsplit(yp$authorString, ", "))), decreasing=TRUE)[1:15])
"yp"
