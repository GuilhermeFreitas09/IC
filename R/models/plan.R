plan <- function(what_step){

  # Carregando dados iniciais e calculando/salvando matriz de betas

  load("../../data/mSetSqFinal.rds")
  matriz_betas <- minfi::getBeta(mSetSq)
  matriz_betas <- t(matriz_betas)
  save(matriz_betas, file = "../../data/matriz_betas.rds")

  # Calculando matriz de distâncias

  ## Completa

  matriz_dist <- stats::dist(matriz_betas)
  save(matriz_dist, file="../../data/matriz_dist.rds")

  ## UMAP

  reducao_umap <- umap::umap(matriz_betas); remove(matriz_betas); gc()
  matriz_dist_umap <- stats::dist(reducao_umap$layout)
  save(matriz_dist_umap, file="../../data/matriz_dist_umap.rds")
  dados_umap <- data.frame(reducao_umap$layout)
  remove(matriz_dist_umap)

  # PAM

  wss <- wss_pam_final(matriz_dist)
  wss_fig_pam(wss)
  modelo_pam <- cluster::pam(matriz_dist, k=2)
  fig_pam_final(modelo_pam, dados_umap)

  remove(wss); remove(modelo_pam); gc()

  # Kmeans

  wss <- wss_kmeans(matriz_dist)

  modelo_kmeans <- stats::kmeans(matriz_dist, 3)
  wss_fig_kmeans(wss)
  silh_kmeans(modelo_kmeans, matriz_dist)
  fig_kmeans_final(modelo_kmeans, dados_umap)

  remove(wss); remove(modelo_kmeans); gc()
}
