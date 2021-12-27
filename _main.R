source("R/check_dependencies.R")
source("R/preprocess/quality_control.R")
source("R/what_steps.R")
source("R/plan.R")

start.time <- Sys.time()


print("Checa as dependencias")
my_dependencies_check()

print("Carrega os pacotes")
my_libraries()


plan(first_step)



end.time <- Sys.time()
print("Tempo de execução")
print(end.time - start.time)
