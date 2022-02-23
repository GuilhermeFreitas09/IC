plan <- function(what_step){
  # Raw data

  cat(crayon::green("RawData\n"))
  load("../../data/rgSet.rds")

  # pré-processamento

  cat(crayon::green("Pŕe-processamento\n"))

  ## Controle de qualidade

  cat(crayon::green("  Controle de qualidade\n"))

  qcrep(rgSet); gc()

  mSet <- mset_gen(rgSet); grafQuality(mSet)
  remove(mSet); gc()

  cat(crayon::green("     Matriz de pvalores\n"))

  detP <- pvalores(rgSet)

  keep <- filt_amost(detP)
  detP <- detP[,keep]; rgSet <- rgSet[,keep]

  ## Normalização

  cat(crayon::green("  Normalização\n"))

  mSetSq <- prepro_norm(rgSet); gc()

  cat(crayon::green("     Gráficos\n"))

  graf_rawVSnorm(mSetSq, rgSet);

  rgsetSave(rgSet); remove(rgSet); gc()

  detP <- detP[match(Biobase::featureNames(mSetSq),rownames(detP)),]
  gc()

  ## Filtragem das probes (CpGs)

  cat(crayon::green("  Filtragem das probes\n"))

  keep <- filtro_sondas(detP, mSetSq)
  detP <- detP[keep,]; mSetSq <- mSetSq[keep,]
  remove(keep); gc()

  keep <- filtro_crsx(mSetSq)
  detP <- detP[keep,]; mSetSq <- mSetSq[keep,]
  remove(keep); gc()

  keep <- filtro_snp(detP, mSetSq)
  detP <- detP[keep,]; mSetSq <- mSetSq[keep,]
  remove(keep); gc()

  keep <- filtro_reatcruz(mSetSq)
  detP <- detP[keep,]; mSetSq <- mSetSq[keep,]
  remove(keep); gc()

  ## Salvando os objetos finais

  cat(crayon::green("  Salvando os objetos\n"))

  save_final_obj(mSetSq, detP)

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
