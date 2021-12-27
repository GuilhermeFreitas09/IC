# Relatório de qualidade inicial
qcrep <- function(rgSet){
  minfi::qcReport(rgSet, pdf = "data/qcReport.pdf")
}

# Gráfico QC

## Gera o mSet
mset_gen <- function(rgSet){
  mSet <- minfi::preprocessRaw(rgSet)
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

  grafico <- ggplot2::ggplot(filtro_amostras) +
    ggplot2::geom_bar(aes(x = amostra, y = media), stat = "identity", fill="#1f9e78") +
    ggplot2::geom_abline(slope = 0, intercept = 0.00045, color="red") +
    ggplot2::ylim(0, 0.0005) +
    ggplot2::xlab("Amostra") +
    ggplot2::ylab("Média") +
    ggplot2::theme_bw() +
    ggplot2::theme(panel.grid.major = ggplot2::element_blank(),
          panel.grid.minor = ggplot2::element_blank(),
          panel.background = ggplot2::element_blank(),
          axis.text.x = ggplot2::element_text(angle = 90, vjust = 0.5, hjust=1))

  ggplot2::ggsave(filename = "pvaluesMean_probes.png", plot = grafico, path = 'imagens/', height = 4)

  remove(grafico); remove(filtro_amostras); gc()

  # Filtro das amostras
  keep <- colMeans(detP) < 0.05
  return(keep)
}

# Pré-processamento

## Normalização
prepro_norm <- function(rgSet){
  mSetSq <- minfi::preprocessQuantile(rgSet)
  save(mSetSq,file="data/mSetSq.rds")
  return(mSetSq)
}

## Gráficos
graf_rawVSnorm <- function(mSetSq, rgSet){

  png(file = "imagens/densidades_preprocessQuantile.png")
  par(mfrow=c(2,1))
  minfi::densityPlot(rgSet,main="Dados Brutos", legend=FALSE)
  minfi::densityPlot(minfi::getBeta(mSetSq),main="Dados Pré-processados", legend=FALSE)
  dev.off(); gc()

  png(file = "imagens/boxplots_preprocessQuantile.png")
  par(mfrow=c(2,1))
  boxplot(minfi::getBeta(rgSet),main="Dados Brutos", ylab="Beta", legend=FALSE, col="#1f9e78", cex.axis=0.7, las=2)
  boxplot(minfi::getBeta(mSetSq),main="Dados Pré-processados", ylab="Beta", legend=FALSE, col="#1f9e78", cex.axis=0.7, las=2)
  dev.off(); gc()

  png(file = "imagens/densityBean_preprocessQuantile.png")
  par(mfrow=c(1,2), mai=c(1.0,1.4,.8,.2))
  minfi::densityBeanPlot(rgSet, main = "Dados Brutos")
  minfi::densityBeanPlot(minfi::getBeta(mSetSq), main = "Dados Pŕe-processados")
  dev.off(); gc()

  # mdsPlot(getBeta(mSetSq))

  # controlStripPlot(rgSet)
}

# Salvando o rgSet após a filtragem das amostras
rgsetSave <- function(rgSet){
  save(rgSet, file="data/rgSetFinal.rds")
}

# Fitragem das sondas

##  Sondas/CpG's problemáticas (pvalor)
filtro_sondas <- function(detP, mSetSq){
  return(rowSums(detP < 0.01) == ncol(mSetSq))
}

## Filtragem das probes dos cromossomos de sexo
filtro_crsx <- function(mSetSq){
  annEPIC <- minfi::getAnnotation(IlluminaHumanMethylationEPICanno.ilm10b4.hg19::IlluminaHumanMethylationEPICanno.ilm10b4.hg19)
  keep <- !(Biobase::featureNames(mSetSq) %in% annEPIC$Name[annEPIC$chr %in% c("chrX","chrY")])
  remove(annEPIC); gc()
  return(keep)
}

## Remoção das sondas com SNP nos campos de CpGs
filtro_snp <- function(detP, mSetSq){
  return(rownames(detP) %in% rownames(minfi::dropLociWithSnps(mSetSq)))
}

## Exclusão de sondas com reatividade cruzada
filtro_reatcruz <- function(mSetSq){
  return(!(featureNames(mSetSq) %in% maxprobes::xreactive_probes(array_type = "EPIC")))
}

# Salvando objetos finais
save_final_obj <- function(mSetSq, detP){
  save(mSetSq,file="data/mSetSqFinal.rds")
  write.csv(detP, "data/pvaloFinal.csv", row.names=T)
}


######## TESTE
#check_teste <- function(){print(getwd())}
