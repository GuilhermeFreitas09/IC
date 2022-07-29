source("check_dependencies.R")
source("quality_control.R")
source("plan.R")

start.time <- Sys.time()


print("Checa as dependencias")

my_dependencies_check()

#print("Carrega os pacotes"); my_libraries()

plan()


end.time <- Sys.time()
cat(crayon::blue("Tempo de execução: \n", end.time - start.time, "\n"))
