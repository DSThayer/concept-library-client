#install.packages('devtools');
#install.packages('roxygen2');
#install.packages('testthat');
#install.packages('GetoptLong');
#install.packages('crul');
#install.packages('jsonlite');

library('devtools');
library('roxygen2');
library('testthat');

#create('ConceptLibraryClient');

#setwd('./ConceptLibraryClient');

#usethis::proj_set(path='./ConceptLibraryClient',force=TRUE)
#usethis::use_testthat()

document();
install();
build();
devtools::test()
