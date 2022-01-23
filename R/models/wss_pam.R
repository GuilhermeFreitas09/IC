# A seguinte função calcula o WSS para gerar o gráfico de Elbow

wss_func <- function(modelo_pam, matriz_dist){
   '
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
