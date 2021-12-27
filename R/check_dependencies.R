# Checa dependências
my_dependencies_check <- function(){

  if(!require("Bioconductor")){install.packages("Bioconductor")}

  if(!require("limma")){BiocManager::install("limma")}

  if(!require("minfi")){BiocManager::install("minfi")}

  if(!require("minfiData")){BiocManager::install("minfiData")}

  if(!require("missMethyl")){BiocManager::install("missMethyl")}

  if(!require("IlluminaHumanMethylationEPICanno.ilm10b4.hg19")){
    BiocManager::install("IlluminaHumanMethylationEPICanno.ilm10b4.hg19")}

  if(!require("IlluminaHumanMethylationEPICmanifest")){
    BiocManager::install("IlluminaHumanMethylationEPICmanifest")}

  if(!require("RColorBrewer")){install.packages("RColorBrewer")}

  if(!require("readr")){install.packages("readr")}

  if(!require("maxprobes")){
    if(!require("remotes")){install.packages("remotes")}
    remotes::install_github("markgene/maxprobres")
  }

  if(!require("dplyr")){install.packages("dplyr")

  if(!require("ggplot2")){install.packages("ggplot2")}



}


'
# Carrega os pacotes
my_libraries <- function(){

  library(limma)
  library(minfi)
  library(minfiData)
  library(missMethyl)
  library(IlluminaHumanMethylationEPICanno.ilm10b4.hg19)
  library(IlluminaHumanMethylationEPICmanifest)
  library(RColorBrewer)
  library(readr)
  library(maxprobes)
  library(dplyr)
  library(ggplot2)

}
''
