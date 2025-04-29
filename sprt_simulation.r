library(ggplot2)

# Function to compute Wald's boundaries
compute_wald_boundaries <- function(alpha_0, alpha_1) {
  a0 <- log(alpha_1 / (1 - alpha_0))  # Lower boundary
  a1 <- log((1 - alpha_1) / alpha_0)  # Upper boundary
  return(list(a0 = a0, a1 = a1))
}

# Function to compute kernel matrix K
compute_K <- function(y, x, theta, theta0, theta1, sigma) {
  # Gaussian parameters
  mu <- (theta1 - theta0) / sigma^2 * (theta - (theta0 + theta1) / 2)
  variance <- ((theta1 - theta0) / sigma)^2
  
  # Gaussian CDF
  gaussian_cdf <- function(z, mu, variance) {
    pnorm(z, mean = mu, sd = sqrt(variance))
  }
  
  # Compute K[i, j]
  K <- outer(x, y[-1], function(xi, yj) {
    gaussian_cdf(yj - xi, mu, variance)
  }) - outer(x, y[-length(y)], function(xi, yj) {
    gaussian_cdf(yj - xi, mu, variance)
  })
  
  return(K)
}

# Function to compute ASN numerically
compute_ASN <- function(a0, a1, theta, theta0, theta1, sigma, N) {
  # Discretize the interval [-a0, a1]
  y <- seq(a0, a1, length.out = N + 1)  # Partition points
  x <- (head(y, -1) + tail(y, -1)) / 2  # Midpoints
  delta_y <- diff(y)[1]  # Subinterval width (assuming uniform grid)
  
  # Compute kernel matrix K
  K <- compute_K(y, x, theta, theta0, theta1, sigma) * delta_y
  
  # Identity matrix and vector of ones
  I <- diag(N)
  ones <- rep(1, N)
  
  # Solve for ASN: (I - K) * ASN = 1
  ASN <- solve(I - K, ones)
  
  # Return results
  return(data.frame(x = x, ASN = ASN))
}

# Main parameters
alpha_0 <- 0.001
alpha_1 <- 0.001
theta_0 <- 0
theta_1 <- 0.5
sigma <- 1
N <- 100

# Compute Wald's boundaries
boundaries <- compute_wald_boundaries(alpha_0, alpha_1)
a0 <- boundaries$a0
a1 <- boundaries$a1

# Range of θ values
theta_values <- seq(theta_0, theta_1, length.out = 100)

# Compute ASN for each θ
asn_results <- lapply(theta_values, function(theta) {
  compute_ASN(a0, a1, theta, theta_0, theta_1, sigma, N)
})

# Extract the average ASN values
asn_values <- sapply(asn_results, function(res) mean(res$ASN))

# Prepare data for ggplot2
asn_data <- data.frame(theta = theta_values, ASN = asn_values)

# Plot ASN(θ) using ggplot2
ggplot(asn_data, aes(x = theta, y = ASN)) +
  geom_line(size = 1) +
  labs(
    title = "ASN(θ) as a Function of θ",
    x = expression(theta),
    y = "Average Sample Number (ASN)"
  ) +
  theme_minimal(base_size = 14)
