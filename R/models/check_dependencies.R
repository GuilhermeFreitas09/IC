my_dependencies_check_models <- function(){

  #if(!require("M3C")){BiocManager::install("M3C")}

  if(!require("dplyr")){install.packages("dplyr")}

  if(!require("ggplot2")){install.packages("ggplot2")}

  if(!require("crayon")){install.packages("crayon")}

  if(!require("cluster")){install.packages("cluster")}

}
