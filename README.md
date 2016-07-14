
## euPMC

 The `euPMC` package formats `epmc_search` results from [europepmc](https://github.com/ropensci/europepmc) and outputs Markdown reference lists, Javascript DataTables, and publication time series. Use `devtools` to install the packages from GitHub.

```r
library(devtools)
install_github("ropensci/europepmc")
install_github("cstubben/euPMC")

```
A detailed description of search fields and example queries are available from the Europe PMC [help pages](https://europepmc.org/Help#directsearch). The first example searches for *Yersinia pestis* virulence in the title from MEDLINE sources (with pubmed IDs).   The `epmc_hits` function returns the number of hits, which can then be used to adjust the default limit of 25 results in `epmc_search`.


```r
library(europePMC)
library(euPMC)

query <- "title:(Yersinia pestis virulence) AND src:MED"
epmc_hits(query)
[1] 160

yp <- epmc_search(query, limit=200)
## 160 records found

t(yp[yp$pmid %in% 24520064,])
                     10                                                                                                                                                
id                    "24520064"                                                                                                                                        
source                "MED"                                                                                                                                             
pmid                  "24520064"                                                                                                                                        
title                 "Posttranscriptional regulation of the Yersinia pestis cyclic AMP receptor protein Crp and impact on virulence."                                  
authorString          "Lathem WW, Schroeder JA, Bellows LE, Ritzert JT, Koo JT, Price PA, Caulfield AJ, Goldman WE."                                                    
journalTitle          "MBio"                                                                                                                                            
journalVolume         "5"                                                                                                                                               
pubYear               "2014"                                                                                                                                            
journalIssn           "2150-7511"                                                                                                                                       
pageInfo              "e01038-13"                                                                                                                                       
pubType               "journal article; citations from index medicus journals; research support, non-u.s. gov't; research support, n.i.h., extramural; research-article"
inEPMC                "Y"                                                                                                                                               
inPMC                 "Y"                                                                                                                                               
hasPDF                "Y"                                                                                                                                               
hasBook               "N"                                                                                                                                               
hasSuppl              "N"                                                                                                                                               
citedByCount          "8"                                                                                                                                               
hasReferences         "Y"                                                                                                                                               
hasTextMinedTerms     "Y"                                                                                                                                               
hasDbCrossReferences  "Y"                                                                                                                                               
hasLabsLinks          "N"                                                                                                                                               
epmcAuthMan           "N"                                                                                                                                               
hasTMAccessionNumbers "N"                                                                                                                                               
luceneScore           NA                                                                                                                                                
doi                   NA                                                                                                                                                
pmcid                 "PMC3950509"                                                                                                                                      
issue                 "1"                                                                                                                                               
isOpenAccess          "Y"      
```


The next query downloads eight papers citing Lathem et al. 2014 above. 



```r
x <- epmc_search( "cites:24520064_MED")
## 8 records found
```

`bib_format` uses helper functions `authors_etal` and `journal_cite` to format author, year, title and journal and optionally add Pubmed IDs and cited by counts into a reference list.  Markdown links are added to journals, PubMed IDs and Cited By counts if displayed.


```r
bib_format(x)
bib_format(x, number=TRUE, pmid=TRUE, cited =TRUE, links=TRUE)
cat(strwrap(bib_format(x, number=TRUE, links=TRUE), width=100, exdent=3), sep="\n")
```

1. Zimbler DL, Schroeder JA, Eddy JL, Lathem WW. 2015. Early emergence of Yersinia pestis as a
   severe respiratory pathogen. [Nat Commun 6:7487](http://dx.DOI.org/10.1038/ncomms8487).
2. Nuss AM, Heroven AK, Waldmann B, et al. 2015. Transcriptomic profiling of Yersinia
   pseudotuberculosis reveals reprogramming of the Crp regulon by temperature and uncovers Crp as a
   master regulator of small RNAs. [PLoS Genet
   11(3):e1005087](http://dx.DOI.org/10.1371/journal.pgen.1005087).
3. Ross JA, Trussler RS, Black MD, et al. 2014. Tn5 transposition in Escherichia coli is repressed
   by Hfq and activated by over-expression of the small non-coding RNA SgrS. [Mob DNA
   5(1):27](http://dx.DOI.org/10.1186/s13100-014-0027-z).
4. Heroven AK, Dersch P. 2014. Coregulation of host-adapted metabolism and virulence by pathogenic
   yersiniae. [Front Cell Infect Microbiol 4:146](http://dx.DOI.org/10.3389/fcimb.2014.00146).
5. Eddy JL, Gielda LM, Caulfield AJ, et al. 2014. Production of outer membrane vesicles by the
   plague pathogen Yersinia pestis. [PLoS One
   9(9):e107002](http://dx.DOI.org/10.1371/journal.pone.0107002).
6. Caulfield AJ, Lathem WW. 2014. Disruption of fas-fas ligand signaling, apoptosis, and innate
   immunity by bacterial pathogens. [PLoS Pathog
   10(8):e1004252](http://dx.DOI.org/10.1371/journal.ppat.1004252).
7. Papenfort K, Vogel J. 2014. Small RNA functions in carbon metabolism and virulence of enteric
   pathogens. [Front Cell Infect Microbiol 4:91](http://dx.DOI.org/10.3389/fcimb.2014.00091).
8. Schiano CA, Koo JT, Schipma MJ, et al. 2014. Genome-wide analysis of small RNAs expressed by
   Yersinia pestis identifies a regulator of the Yop-Ysc type III secretion system. [J Bacteriol
   196(9):1659-1670](http://dx.DOI.org/10.1128/jb.01456-13).

`DT_format` adds html links to PubMed IDs, journal, and cited by counts for displaying using the `datatable` function in the DT package.  Click the [link](http://cstubben.github.io/genomes/yp.html) or image to view the interactive table. 


```r
library(DT)
y<-DT_format(yp)
datatable(y, escape = c(1,5),  caption="Publications with Yersinia pestis virulence in the title") 
```

[![DataTable](DT.png)](http://cstubben.github.io/genomes/yp.html)

The `year_ts` function creates yearly time-series objects using the publication year.


```r
y <- year_ts(yp)
plot(y, xlab="Year published", ylab="Articles per year", las=1)
```

Many time series objects can be combined and then plotted in a single plot or interactive [dygraph](http://cstubben.github.io/genomes/FigS1.html).  In this plot, citations to 65 marine genome publications funded by the Gordon and Betty Moore Foundation are plotted using the `dygraphs` package.  Click the [link](http://cstubben.github.io/genomes/FigS1.html) or image to view the interactive plot. 

[![Dygraph](yp.png)](http://cstubben.github.io/genomes/FigS1.html)


The final query returns publications with the species *Waddlia chondrophila* in the abstract.  `table2` is a wrapper for `table` and returns  sorted counts as a data.frame.

```
query <- 'abstract:"Waddlia chondrophila" AND SRC:MED'
epmc_hits(query)
[1] 63

wc <- epmc_search(query, limit =100)
table2(wc$journalTitle)
                                n
Microbes Infect                 8
PLoS One                        6
Emerg Infect Dis                4
FEMS Immunol Med Microbiol      3
J Vet Diagn Invest              3
Microbiology                    3
New Microbes New Infect         3
Vet Microbiol                   3
Clin Microbiol Infect           2
Eur J Clin Microbiol Infect Dis 2
```

The package also includes a list of journals currently or previously indexed in MEDLINE in the NLM catalog at NCBI.  This table includes MeSH terms assigned to the journal, which can be used to summarize the publications about *Waddlia chondrophila*  (which could be considered a new emerging zoonotic pathogen based on the journal sources).

```
data(nlm)

n <- match(wc$journalTitle, nlm$ta)
# one journal not indexed in MEDLINE
table(wc$journalTitle[which(is.na(n))])
New Microbes New Infect 
                      3 

table2(unlist(strsplit(nlm$mesh[n], "; ")))
                              n
Microbiology                 21
Communicable Diseases        13
Infection                    13
Immunity                      9
Medicine                      6
Science                       6
Veterinary Medicine           6
Animal Diseases               4
Communicable Disease Control  4
Microbiological Phenomena     4

