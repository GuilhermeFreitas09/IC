source("R/check_dependencies.R")

#my_dependencies_check()

#my_libraries()

plan <- function(){
  # Raw data
  load("data/rgSetSample.rds")

  # Relatório de qualidade
  minfi::qcReport(rgSet, pdf = "data/qcReport.pdf")
}

plan()
