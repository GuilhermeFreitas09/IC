source("check_dependencies.R")
source("quality_control.R")
#source("what_steps.R")
source("plan.R")

start.time <- Sys.time()


#novalib <- .libPaths()

#novalib <- c(novalib, '/home/lovelace/proj/proj858/gpereira/pacotesR')

#.libPaths(novalib)

print("Checa as dependencias")

my_dependencies_check()

#print("Carrega os pacotes"); my_libraries()

plan(first_step)


end.time <- Sys.time()
cat(crayon::blue("Tempo de execução: \n", end.time - start.time, "\n"))
