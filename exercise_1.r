# EXERCISE 1: Beta Prior Distributions for Binary Endpoints
# Load required libraries
library(ggplot2)

# Set seed for reproducibility
set.seed(123)

print("EXERCISE 1: Simulating Beta Prior Distributions")
print(paste(rep("=", 50), collapse = ""))

# Define the five Beta distributions
beta_params <- list(
  c(8, 12),   # (i) Beta(8, 12)
  c(4, 6),    # (ii) Beta(4, 6)
  c(2, 2),    # (iii) Beta(2, 2)
  c(1, 1),    # (iv) Beta(1, 1)
  c(0.5, 0.5) # (v) Beta(0.5, 0.5)
)

# Draw 10,000 samples from each distribution
n_samples <- 10000
samples_list <- list()

for (i in 1:5) {
  alpha <- beta_params[[i]][1]
  beta <- beta_params[[i]][2]
  samples_list[[i]] <- rbeta(n_samples, alpha, beta)
}

# Create density plots
par(mfrow = c(2, 3))
for (i in 1:5) {
  alpha <- beta_params[[i]][1]
  beta <- beta_params[[i]][2]
  
  # Plot density
  plot(density(samples_list[[i]]), 
       main = paste0("Beta(", alpha, ", ", beta, ")"),
       xlab = "Proportion (π)",
       ylab = "Density",
       xlim = c(0, 1),
       col = "blue",
       lwd = 2)
  
  # Add vertical line at mean
  mean_val <- alpha / (alpha + beta)
  abline(v = mean_val, col = "red", lty = 2)
  
  # Print interpretation
  print(paste0("Beta(", alpha, ", ", beta, "):"))
  print(paste0("  Mean = ", round(mean_val, 3)))
  print(paste0("  Variance = ", round(alpha * beta / ((alpha + beta)^2 * (alpha + beta + 1)), 4)))
  
  # Interpretation of prior beliefs
  if (i == 1) {
    print("  Interpretation: Moderate belief centered at 0.4, fairly informative")
  } else if (i == 2) {
    print("  Interpretation: Weak belief centered at 0.4, somewhat informative")
  } else if (i == 3) {
    print("  Interpretation: Uniform on (0,1) with slight peak at 0.5, weakly informative")
  } else if (i == 4) {
    print("  Interpretation: Uniform distribution, non-informative")
  } else {
    print("  Interpretation: U-shaped, Jeffreys prior, non-informative")
  }
  print("")
}