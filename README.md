
## euPMC

The `euPMC` package formats `epmc_search` results from
[europepmc] and outputs Markdown
reference lists, Javascript DataTables, and publication time series. Use
`devtools` to install the packages from GitHub.

```r
library(devtools)
install_github("ropensci/europepmc")
install_github("cstubben/euPMC")
```

Try searching Europe PMC using the Shiny app to view some example tables and plots.

https://cstubben.shinyapps.io/euPMC/


A detailed description of search fields and example queries are available from
the Europe PMC [help pages]. The first
example searches for *Yersinia pestis* virulence in the title from MEDLINE
sources (with pubmed IDs).  The `epmc_hits` function returns the number of
hits, which can then be used to adjust the default limit of 25 results in
`epmc_search`.


```r
library(europepmc)
library(euPMC)

query <- "title:(Yersinia pestis virulence) AND src:MED"
epmc_hits(query)
# [1] 148

yp <- epmc_search(query, limit=200)
# 148 records found, returning 148

dplyr::filter(yp, pmid==23357388) %>% t()
                      [,1]
id                    "23357388"
source                "MED"
pmid                  "23357388"
pmcid                 "PMC3639585"
doi                   "10.1128/IAI.01417-12"
title                 "RfaL is required for Yersinia pestis type III secretion and virulence."
authorString          "Houppert AS, Bohman L, Merritt PM, Cole CB, Caulfield AJ, Lathem WW, Marketon MM."
journalTitle          "Infect Immun"
issue                 "4"
journalVolume         "81"
pubYear               "2013"
journalIssn           "0019-9567; 1098-5522; "
pageInfo              "1186-1197"
pubType               "research support, non-u.s. gov't; research-article; journal article; research ..."
isOpenAccess          "N"
inEPMC                "Y"
inPMC                 "Y"
hasPDF                "Y"
hasBook               "N"
hasSuppl              "Y"
citedByCount          "7"
hasReferences         "Y"
hasTextMinedTerms     "Y"
hasDbCrossReferences  "N"
hasLabsLinks          "Y"
hasTMAccessionNumbers "N"
firstPublicationDate  "2013-01-28"
```


The next query downloads seven papers citing Houppert et al. 2013 above.


```r
x <- epmc_search( "cites:23357388_MED")
# 7 records found, returning 7
```

`bib_format` uses helper functions `authors_etal` and `journal_cite` to format author,
year, title and journal and optionally add Pubmed IDs and cited by counts into a
reference list.  Markdown links are added to journals, PubMed IDs and Cited By counts if displayed.


```r
x <- arrange(x, authorString)
bib_format(x)
bib_format(x, number=TRUE, pmid=TRUE, cited =TRUE, links=TRUE)
cat(strwrap(bib_format(x, number=TRUE, links=TRUE), width=100, exdent=3), sep="\n")
```

1. Caulfield AJ, Walker ME, Gielda LM, Lathem WW. 2014. The Pla protease of Yersinia pestis
   degrades fas ligand to manipulate host cell death and inflammation. [Cell Host Microbe
   15(4):424-434](https://doi.org/10.1016/j.chom.2014.03.005)
2. da Silva P, Manieri FZ, Herrera CM, et al. 2018. Novel Role of VisP and the Wzz System during
   O-Antigen Assembly in Salmonella enterica Serovar Typhimurium Pathogenesis. [Infect Immun
   86(8)](https://doi.org/10.1128/iai.00319-18)
3. Earl SC, Rogers MT, Keen J, et al. 2015. Resistance to Innate Immunity Contributes to
   Colonization of the Insect Gut by Yersinia pestis. [PLoS One
   10(7):e0133318](https://doi.org/10.1371/journal.pone.0133318)
4. Eddy JL, Gielda LM, Caulfield AJ, et al. 2014. Production of outer membrane vesicles by the
   plague pathogen Yersinia pestis. [PLoS One
   9(9):e107002](https://doi.org/10.1371/journal.pone.0107002)
5. Lathem WW, Schroeder JA, Bellows LE, et al. 2014. Posttranscriptional regulation of the Yersinia
   pestis cyclic AMP receptor protein Crp and impact on virulence. [MBio
   5(1):e01038-13](https://doi.org/10.1128/mBio.01038-13)
6. Merritt PM, Nero T, Bohman L, et al. 2015. Yersinia pestis targets neutrophils via complement
   receptor 3. [Cell Microbiol 17(5):666-687](https://doi.org/10.1111/cmi.12391)
7. Ritzert JT, Lathem WW. 2018. Depletion of Glucose Activates Catabolite Repression during
   Pneumonic Plague. [J Bacteriol 200(11)](https://doi.org/10.1128/jb.00737-17)


`DT_format` adds html links to PubMed IDs, journal, and cited by counts for displaying
using the `DT` package.


```r
library(DT)
y<-DT_format(yp)
datatable(y, escape = c(1,5),  caption="Publications with Yersinia pestis virulence in the title")
```

![DataTable](DT.png)

<br>

The `year_ts` function creates yearly time-series objects using the publication year for plotting using the `dygraphs` package.


```r
y <- year_ts(yp)
dygraph(y, xlab="Year published", ylab="Articles per year")
```

![Dygraph](yp.png)

<br>

The final query returns publications with the species *Waddlia chondrophila* in the abstract.

```r
query <- 'abstract:"Waddlia chondrophila" AND SRC:MED'
epmc_hits(query)
[1] 73

wc <- epmc_search(query, limit =100)
dplyr::count(wc, journalTitle, sort=TRUE)
# # A tibble: 43 x 2
#   journalTitle                        n
#   <chr>                           <int>
# 1 Microbes Infect                     8
# 2 PLoS One                            6
# 3 Emerg Infect Dis                    4
# 4 New Microbes New Infect             4
# 5 Clin Microbiol Infect               3
# 6 FEMS Immunol Med Microbiol          3
# 7 J Vet Diagn Invest                  3
# 8 Microbiology                        3
# 9 Vet Microbiol                       3
#10 Eur J Clin Microbiol Infect Dis     2
```

The package also includes a list of journals indexed in MEDLINE in the NLM
catalog at NCBI.  This table includes MeSH terms assigned to the journal, which
can be used to summarize the publications about *Waddlia chondrophila*  (which
could be considered a new emerging zoonotic pathogen based on the journal
sources).

```r
data(nlm)
inner_join(wc, nlm, by=c(journalTitle="ta")) %>%
 tidyr::separate_rows(mesh, sep="; ") %>% dplyr::count(mesh, sort=TRUE)
# # A tibble: 57 x 2
#   mesh                              n
#   <chr>                         <int>
# 1 Microbiology*                    19
# 2 Immunity*                         9
# 3 Infection                         9
# 4 Communicable Diseases*            7
# 5 Medicine*                         7
# 6 Science                           6
# 7 Veterinary Medicine*              6
# 8 Infection*                        5
# 9 Allergy and Immunology*           4
#10 Communicable Disease Control*     4
## ... with 47 more rows
```


[europepmc]: https://github.com/ropensci/europepmc
[help pages]: https://europepmc.org/Help#directsearch
