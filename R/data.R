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
#' }
#'
#' @source \url{http://www.ncbi.nlm.nih.gov/nlmcatalog}
#'
#' @examples
#' data(nlm)
#' filter(nlm, grepl("Heart Diseases", mesh) )
#' # sort( table(unlist(strsplit(nlm$mesh, "; "))), decreasing=TRUE)[1:10]
#' tidyr::separate_rows(nlm, mesh, sep="; ") %>% dplyr::count(mesh, sort=TRUE)
#'
"nlm"

#' Yersinia pestis virulence publications
#'
#' Europe PMC search results with Yersinia pestis virulence in title
#'
#' @format A data frame with 148 observations and 26 columns.
#' @source Europe PMC search
#' @examples
#' data(yp)
#' yp
#' t(yp[7,])
#' bib_format(yp[1:7,])
#' tidyr::separate_rows(yp, pubType, sep="; ") %>% dplyr::count(pubType, sort=TRUE)
#' dplyr::filter(yp[, c(3,6:8,11,14)], grepl("review", pubType))
#' # remove period and split author string
#' dplyr::mutate(yp, author = gsub("\\.$", "", authorString)) %>%
#'  tidyr::separate_rows(author, sep=", ") %>% dplyr::count(author, sort=TRUE)
"yp"
