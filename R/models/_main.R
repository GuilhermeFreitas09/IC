source("check_dependencies.R")
source("clustering.R")
source("plan.R")

start.time <- Sys.time()

cat("Checa as dependencias")

my_dependencies_check_models()

plan()

end.time <- Sys.time()
cat(crayon::blue("Tempo de execução: \n", end.time - start.time, "\n"))
