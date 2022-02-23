# Checa dependências
my_dependencies_check <- function(){

  ll <- '/home/lovelace/proj/proj858/gpereira/pacotesR'

  if (!require("BiocManager", quietly = TRUE, lib.loc=ll)){
    install.packages("BiocManager", lib = ll)}

  library("BiocManager", lib.loc=ll)

  if(!require("limma", lib.loc = ll)){BiocManager::install("limma", lib = ll)}

  if(!require("minfi", lib.loc = ll)){BiocManager::install("minfi", lib = ll)}

  if(!require("minfiData", lib.loc = ll)){BiocManager::install("minfiData", lib = ll)}

  if(!require("missMethyl", lib.loc = ll)){BiocManager::install("missMethyl", lib = ll)}

  if(!require("IlluminaHumanMethylationEPICanno.ilm10b4.hg19", lib.loc = ll)){
    BiocManager::install("IlluminaHumanMethylationEPICanno.ilm10b4.hg19", lib = ll)}

  if(!require("IlluminaHumanMethylationEPICmanifest", lib.loc = ll)){
    BiocManager::install("IlluminaHumanMethylationEPICmanifest", lib = ll)}

   if(!require("maxprobes", lib.loc = ll)){
     if(!require("devtools", lib.loc = ll)){install.packages("devtools", lib = ll)}
     library(devtools, lib.loc=ll)
     devtools::install_github("markgene/maxprobres", lib = ll)
   }

  if(!require("dplyr", lib.loc = ll)){BiocManager::install("dplyr", lib = ll)}

  if(!require("ggplot2", lib.loc = ll)){BiocManager::install("ggplot2", lib = ll)}

  if(!require("crayon", lib.loc = ll)){BiocManager::install("crayon", lib = ll)}

}

# Carrega os pacotes
my_libraries <- function(){
  library(limma, lib.loc = ll)
  library(minfi, lib.loc = ll)
  library(minfiData, lib.loc = ll)
  library(missMethyl, lib.loc = ll)
  library(IlluminaHumanMethylationEPICanno.ilm10b4.hg19, lib.loc = ll)
  library(IlluminaHumanMethylationEPICmanifest, lib.loc = ll)
  library(maxprobes, lib.loc = ll)
  library(dplyr, lib.loc = ll)
  library(ggplot2, lib.loc = ll)
  library(crayon, lib.loc = ll)
}
