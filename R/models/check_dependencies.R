my_dependencies_check_models <- function(){
  if(!require("cluster", lib.loc = ll)){install.packages("cluster", lib = ll)}
  if(!require("ggthemes", lib.loc = ll)){install.packages("ggthemes", lib = ll)}
}
