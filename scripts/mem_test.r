# Function to create a matrix of approximately 'size_in_gb' gigabytes
create_matrix <- function(size_in_gb, bytes = 8) {
  bytes_per_gb <- 1024^3
  element_size <- bytes  # Size of a numeric element in bytes
  total_elements <- (size_in_gb * bytes_per_gb) / element_size
  n_cols <- 1000
  n_rows <- ceiling(total_elements / n_cols)
  matrix(1, nrow = n_rows, ncol = n_cols)
}

# Function to convert object size from bytes to gigabytes
size_in_gb <- function(object) {
  size_in_bytes <- as.numeric(object.size(object))
  size_in_gb <- size_in_bytes / (1024^3)
  return(paste0(round(size_in_gb, 4), " GB"))
}

# Create matrices of different sizes
system.time(
  large_matrix <- create_matrix(1)
)

large_matrix <- create_matrix(1)

size_in_gb(large_matrix)

# Create matrices of different sizes
matrix_1gb <- create_matrix(1)
size_in_gb(matrix_1gb)
matrix_5gb <- create_matrix(5)
size_in_gb(matrix_5gb)
matrix_10gb <- create_matrix(10)
size_in_gb(matrix_10gb)