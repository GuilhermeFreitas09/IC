plan <- function(what_step){

  # Carregando dados iniciais e calculando/salvando matriz de betas

  load("../../data/mSetSqFinal.rds")
  matriz_betas <- minfi::getBeta(mSetSq)
  save(matriz_betas, file = "../../data/matriz_betas.rds")

  # Calculando matriz de distâncias

  ## Completa

  matriz_dist <- stats::dist(matriz_betas)
  save(matriz_dist, file="../../data/matriz_dist.rds")

  ## UMAP

  reducao_umap <- umap::umap(matriz_betas); remove(matriz_betas); gc()
  matriz_dist_umap <- stats::dist(reducao_umap$layout)
  save(matriz_dist_umap, file="../../data/matriz_dist_umap.rds")

  # PAM

  ## Número de clusteres

  ## Dist completa

  ## Dist UMAP

  # Kmeans

  ## Número de clusteres

  ## Dist completa

  ## Dist UMAP


}
