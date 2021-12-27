source("R/check_dependencies.R")
source("R/preprocess/quality_control.R")
source("R/what_steps.R")
source("R/plan.R")

start.time <- Sys.time()


cat(crayon::green("Checa as dependencias\n"))

my_dependencies_check()

# print("Carrega os pacotes"); my_libraries()

plan(first_step)


end.time <- Sys.time()
cat(crayon::blue("Tempo de execução: \n", end.time - start.time, "\n"))
