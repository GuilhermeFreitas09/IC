plan <- function(what_step){
  # Raw data
  print("--RawData--")
  load("data/rgSetSample.rds")

  '
  # pré-processamento
  '
  print("--Pŕe-processamento--")

  '
  ## Controle de qualidade
  '
  print("Controle de qualidade")

  ### Relatório de qualidade
  qcrep(rgSet)

  ### QCplot
  mSet <- mset_gen(rgSet); grafQuality(mSet)
  remove(mSet); gc()

  ### Cálculo matriz de pvaloes
  detP <- pvalores(rgSet)

  ### Filtro das amostras
  keep <- filt_amost(detP)
  detP <- detP[,keep]; rgSet <- rgSet[,keep]

  '
  ## Normalização
  '
  print("Normalização")

  ### preprocessQuantile
  mSetSq <- prepro_norm(rgSet)

  ### Gráficos
  graf_rawVSnorm(mSetSq, rgSet)

  '
  ## Filtragem das probes (CpGs)
  '

  ###  Sondas/CpG's problemáticas (pvalor)
  keep <- filtro_sondas(detP, mSetSq)
  detP <- detP[,keep]; rgSet <- rgSet[,keep]; mSetSq <- mSetSq[,keep]

  ### Filtragem das probes dos cromossomos de sexo
  keep <- filtro_crsx(mSetSq)
  detP <- detP[,keep]; rgSet <- rgSet[,keep]; mSetSq <- mSetSq[,keep]

  ### Remoção das sondas com SNP nos campos de CpGs
  keep <- filtro_snp(detP, mSetSq)
  detP <- detP[,keep]; rgSet <- rgSet[,keep]; mSetSq <- mSetSq[,keep]

  ### Exclusão de sondas com reatividade cruzada
  keep <- filtro_reatcruz(mSetSq)
  detP <- detP[,keep]; rgSet <- rgSet[,keep]; mSetSq <- mSetSq[,keep]
  remove(keep); qc()

  '
  ## Salvando os objetos finais
  '
  print("Salva os objetos finais")
  save_final_obj(mSetSq, detP, rgSet)

  '
  # Machine Learning
  '

}


'
start.time <- Sys.time()
my_dependencies_check()
end.time <- Sys.time()
print("Minhas dependências")
print(end.time - start.time)

start.time <- Sys.time()
my_libraries()
end.time <- Sys.time()
print("Minhas bibliotecas")
print(end.time - start.time)

plan <- function(what_step){
  # Raw data

  start.time <- Sys.time()
  load("data/rgSetSample.rds")
  end.time <- Sys.time()
  print("Raw data")
  print(end.time - start.time)


  # pré-processamento

  ## Controle de qualidade

  ### Relatório de qualidade
  start.time <- Sys.time()
  qcrep(rgSet)
  end.time <- Sys.time()
  print("Relatório de qualidade")
  print(end.time - start.time)


  ### QCplot
  start.time <- Sys.time()
  mSet <- mset_gen(rgSet)
  grafQuality(mSet)
  remove(mSet)
  end.time <- Sys.time()
  print("Execução QCplot")
  print(end.time - start.time)


  ### Cálculo matriz de pvaloes
  start.time <- Sys.time()
  detP <- pvalores(rgSet)
  end.time <- Sys.time()
  print("Cálculo matriz de pvaloes")
  print(end.time - start.time)


}

plan(first_step)
'
