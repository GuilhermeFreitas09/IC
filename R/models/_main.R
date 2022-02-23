source("check_dependencies.R")
source("clustering.R")
source("../what_steps.R")
source("plan.R")

start.time <- Sys.time()

print("Checa as dependencias")

my_dependencies_check_models()

plan(first_step)

end.time <- Sys.time()
cat(crayon::blue("Tempo de execução: \n", end.time - start.time, "\n"))
