# Checa dependências
my_dependencies_check <- function(){

  ll <- '/home/lovelace/proj/proj858/gpereira/pacotesR'

  if (!require("BiocManager", quietly = TRUE, lib.loc=ll)){
    install.packages("BiocManager", lib = ll)

  if(!require("limma", lib.loc = ll)){BiocManager::install("limma", lib = ll)}

  if(!require("minfi", lib.loc = ll)){BiocManager::install("minfi", lib = ll)}

  if(!require("minfiData", lib.loc = ll)){BiocManager::install("minfiData", lib = ll)}

  if(!require("missMethyl", lib.loc = ll)){BiocManager::install("missMethyl", lib = ll)}

  if(!require("IlluminaHumanMethylationEPICanno.ilm10b4.hg19", lib.loc = ll)){
    BiocManager::install("IlluminaHumanMethylationEPICanno.ilm10b4.hg19", lib = ll)}

  if(!require("IlluminaHumanMethylationEPICmanifest", lib.loc = ll)){
    BiocManager::install("IlluminaHumanMethylationEPICmanifest", lib = ll)}

  if(!require("maxprobes", lib.loc = ll)){
    if(!require("remotes", lib.loc = ll)){install.packages("remotes", lib = ll)}
    remotes::install_github("markgene/maxprobres", lib = ll)
  }

  if(!require("dplyr", lib.loc = ll)){install.packages("dplyr", lib = ll)}

  if(!require("ggplot2", lib.loc = ll)){install.packages("ggplot2", lib = ll)}

  if(!require("crayon", lib.loc = ll)){install.packages("crayon", lib = ll)}

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
