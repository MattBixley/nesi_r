library(doParallel)
library(furrr)

# Set up a parallel backend with the number of workers (cores) you want to use
num_cores <- 2  # Adjust the number of cores as needed
cl <- makeCluster(num_cores)
registerDoParallel(cl)

# Set up a parallel plan with furrr
plan(cluster, workers = cl)

# Example function to apply
example_function <- function(x) {
  Sys.sleep(2)  # Simulate a time-consuming task
  x * 2
}

# List of numbers to process
numbers <- list(1, 2, 3, 4, 5)

# Apply the function in parallel using future_map()
result <- future_map(numbers, example_function)

print(result)

# Stop the cluster
stopCluster(cl)

