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

# Filtro de amostras
filt_amost <- function(detP){

  # Gráfico
  filtro_amostras <- data.frame(colMeans(detP))
  filtro_amostras$amostra <- rownames(filtro_amostras)
  rownames(filtro_amostras) <- NULL; colnames(filtro_amostras) <- c("media", "amostra")

  grafico <- ggplot(filtro_amostras) +
    geom_bar(aes(x = amostra, y = media), stat = "identity", fill="#1f9e78") +
    geom_abline(slope = 0, intercept = 0.00045, color="red") +
    ylim(0, 0.0005) +
    xlab("Amostra") +
    ylab("Média") +
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

  ggsave(filename = "pvaluesMean_probes.png", plot = grafico, path = 'imagens/', height = 4)

  remove(grafico); remove(filtro_amostras); gc()

  # Filtro das amostras
  keep <- colMeans(detP) < 0.05
  return(keep)
}

# Pré-processamento

## Normalização
prepro_norm <- function(rgSet){
  mSetSq <- preprocessQuantile(rgSet)
  save(mSetSq,file="data/mSetSq.rds")
  return(mSetSq)
}

## Gráficos
graf_rawVSnorm <- function(mSetSq, rgSet){

  png(file = "imagens/densidades_preprocessQuantile.png")
  par(mfrow=c(2,1))
  densityPlot(rgSet,main="Dados Brutos", legend=FALSE)
  densityPlot(getBeta(mSetSq),main="Dados Pré-processados", legend=FALSE)
  dev.off(); gc()

  png(file = "imagens/boxplots_preprocessQuantile.png")
  par(mfrow=c(2,1))
  boxplot(getBeta(rgSet),main="Dados Brutos", ylab="Beta", legend=FALSE, col="#1f9e78", cex.axis=0.7, las=2)
  boxplot(getBeta(mSetSq),main="Dados Pré-processados", ylab="Beta", legend=FALSE, col="#1f9e78", cex.axis=0.7, las=2)
  dev.off(); gc()

  png(file = "imagens/densityBean_preprocessQuantile.png")
  par(mfrow=c(1,2), mai=c(1.0,1.4,.8,.2))
  densityBeanPlot(getBeta(rgSet), main = "Dados Brutos")
  densityBeanPlot(getBeta(mSetSq), main = "Dados Pŕe-processados")
  dev.off(); gc()

  # mdsPlot(getBeta(mSetSq))

  # controlStripPlot(rgSet)
}

# Fitragem das sondas

##  Sondas/CpG's problemáticas (pvalor)
filtro_sondas <- function(detP, mSetSq){
  detP <- detP[match(featureNames(mSetSq),rownames(detP)),]
  return(rowSums(detP < 0.01) == ncol(mSetSq))
}

## Filtragem das probes dos cromossomos de sexo
filtro_crsx <- function(mSetSq){
  annEPIC <- getAnnotation(IlluminaHumanMethylationEPICanno.ilm10b4.hg19)
  keep <- !(featureNames(mSetSq) %in% annEPIC$Name[annEPIC$chr %in% c("chrX","chrY")])
  return(keep)
}

## Remoção das sondas com SNP nos campos de CpGs
filtro_snp <- function(detP, mSetSq){
  mSetSq <- dropLociWithSnps(mSetSq)
  return(rownames(detP) %in% rownames(mSetSq)) # teria que ser um getBeta aqui!
}

## Exclusão de sondas com reatividade cruzada
filtro_reatcruz <- function(mSetSq){
  xReactiveProbes <- xreactive_probes(array_type = "EPIC")
  return(!(featureNames(mSetSq) %in% xReactiveProbes))
}

# Salvando objetos finais
save_final_obj <- function(mSetSq, detP, rgSet){
  save(mSetSq,file="data/mSetSqFinal.rds")
  save(rgSet, file="data/rgSetFinal.rds")
  write.csv(detP, "data/pvaloFinal.csv", row.names=T)
}





######## TESTE
#check_teste <- function(){print(getwd())}
