# Relatório de qualidade inicial
qcrep <- function(rgSet){
  minfi::qcReport(rgSet, pdf = "data/qcReport.pdf")
}

# Gráfico QC

## Gera o mSet
mset_gen <- function(rgSet){
  mSet <- preprocessRaw(rgSet)
  save(mSet, file="data/mSet.rds")
  return(mSet)
}

## Gera o gráfico de qualidade
grafQuality <- function(mSet){
  png(file = "imagens/QCplot.png") # defaults to 7 x 7 inches
  minfi::plotQC(minfi::getQC(mSet))
  dev.off()
}

# Matriz de pvalores
pvalores <- function(rgSet){
  detP <- data.frame(minfi::detectionP(rgSet))
  write.csv(detP, "data/pvalor.csv", row.names=T)
  return(detP)
}


######## TESTE
check_teste <- function(){print(getwd())}
