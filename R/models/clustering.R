# PAM - Partition Around Medoids

wss_func_pam <- function(modelo_pam, matriz_dist){
   '
   A seguinte função calcula o WSS para gerar o gráfico de Elbow

   modelo_pam: objeto gerado a partir da função pam()
   matriz_dist <- objeto gerado a partir da função dist()
   '
   n <- length(modelo_pam$medoids); wss <- 0
   matriz_dist <- data.frame(as.matrix(matriz_dist))
   data <- data.frame(as.matrix(modelo_pam$clustering))
   colnames(data) <- c('cluster')
   for (j in 1:n) {
     center <- modelo_pam$medoids[j]
     elemen <- rownames(dplyr::filter(data, cluster==j))
     for (el in elemen) {
       wss <- wss + (matriz_dist[el,center])^2
     }
   }
   return(wss)
}

wss_pam_final <- function(matriz_dist){
  wss_final <- c()
  for (i in 1:15) {
    modelo_pam <- cluster::pam(matriz_dist, k=i)
    wss_final[i] <- wss_func_pam(modelo_pam, matriz_dist)
    remove(modelo_pam)
  }
  gc()
  return(wss_final)
}

wss_fig_pam <-function(wss_final){
  df <- data.frame(wss_final, seq(1:15))
  colnames(df) <- c('wss','sequ')
  grafico <- ggplot2::ggplot(df) +
    ggplot2::geom_line(aes(x=sequ, y=wss)) +
    ggplot2::geom_point(aes(x=sequ, y=wss)) +
    ggplot2::theme_bw() +
    ggplot2::xlab("Número de clusters") +
    ggplot2::ylab("WSS")
    # WSS = Within Cluster Sum of Squares (WSS) = Soma dos Quadrados Intra-cluster
    ggplot2::ggsave(filename = "wss_fig_pam.png", plot = grafico, path = '../../imagens/models_images/', height = 4)
}

fig_pam_final <- function(modelo_pam, dados_umap){
  grafico <- ggplot2::ggplot(mutate(dados_umap, cluster = factor(modelo_pam$clustering))) +
    ggplot2::geom_point(aes(x=X1, y=X2, color=cluster)) +
    ggplot2::theme_bw() +
    ggthemes::scale_colour_colorblind() +
    ggplot2::labs(
      x = 'UMAP 1',
      y = 'UMAP 2',
      colour = 'Cluster'
    )
    ggplot2::ggsave(filename = "fig_pam_final.png", plot = grafico, path = '../../imagens/models_images/', height = 4)
}

# Kmeans

wss_kmeans <- function(matriz_dist){
  wss <- sapply(1:15,function(k){kmeans(matriz_dist, k)$tot.withinss})
  return(wss)
}

silh_kmeans <- function(modelo_kmeans, matriz_dist){
  png(file = "../../imagens/models_images/silhouette_kmeans.jpg")
  plot(silhouette(modelo_kmeans$cluster, matriz_dist))
  dev.off()
}

fig_kmeans_final <- function(modelo_kmeans, dados_umap){
  grafico <- ggplot2::ggplot(mutate(dados_umap, cluster = factor(modelo_kmeans$cluster))) +
    ggplot2::geom_point(aes(x=X1, y=X2, color=cluster)) +
    ggplot2::theme_bw() +
    ggthemes::scale_colour_colorblind() +
    ggplot2::labs(
      x = 'UMAP 1',
      y = 'UMAP 2',
      colour = 'Cluster'
    )
    ggplot2::ggsave(filename = "fig_kmeans_final.png", plot = grafico, path = '../../imagens/models_images/', height = 4)
}

wss_fig_kmeans <-function(wss_final){
  df <- data.frame(wss_final, seq(1:15))
  colnames(df) <- c('wss','sequ')
  grafico <- ggplot2::ggplot(df) +
    ggplot2::geom_line(aes(x=sequ, y=wss)) +
    ggplot2::geom_point(aes(x=sequ, y=wss)) +
    ggplot2::theme_bw() +
    ggplot2::xlab("Número de clusters") +
    ggplot2::ylab("WSS")
    # WSS = Within Cluster Sum of Squares (WSS) = Soma dos Quadrados Intra-cluster
    ggplot2::ggsave(filename = "wss_fig_kmeans.png", plot = grafico, path = '../../imagens/models_images/', height = 4)
}
