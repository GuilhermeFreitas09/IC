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
    wss_final[i] <- wss_func(modelo_pam, matriz_dist)
    remove(modelo_pam)
  }
  gc()
  returm(wss_final)
}

wss_fig_pam <-function(wss_final){
  df <- data.frame(wss, seq(1:15))
  colnames(df) <- c('wss','sequ')
  df %>% ggplot() +
    geom_line(aes(x=sequ, y=wss)) +
    geom_point(aes(x=sequ, y=wss)) +
    theme_bw() +
    xlab("") +
    ylab("WSS")
}

fig_pam_final <- function(modelo_pam, df){
  df %>%
    mutate(cluster = factor(modelo_pam$clustering)) %>%
    ggplot() +
    geom_point(aes(x=X1, y=X2, color=cluster)) +
    theme_bw() +
    scale_colour_colorblind() +
    labs(
      x = 'UMAP 1',
      y = 'UMAP 2',
      colour = 'Cluster'
    )
}

# Kmeans

wss_kmeans <- function(matriz_dist){
  wss <- sapply(1:15,function(k){kmeans(matriz_dist, k)$tot.withinss})
  return(wss)
}

silh_kmeans <- function(modelo_kmeans, matriz_dist){
  plot(silhouette(modelo_kmeans$cluster, matriz_dist))
}

fig_kmeans_final <- function(modelo_kmeans, df){
  df %>%
    mutate(cluster = factor(modelo_kmeans$cluster)) %>%
    ggplot() +
    geom_point(aes(x=X1, y=X2, color=cluster)) +
    theme_bw() +
    scale_colour_colorblind() +
    labs(
      x = 'UMAP 1',
      y = 'UMAP 2',
      colour = 'Cluster'
    )
}
