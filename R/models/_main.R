source("check_dependencies.R")
source("models.R")
source("what_steps.R")
source("plan.R")

start.time <- Sys.time()

print("Checa as dependencias")

my_dependencies_check()

plan(first_step)

end.time <- Sys.time()
cat(crayon::blue("Tempo de execução: \n", end.time - start.time, "\n"))
