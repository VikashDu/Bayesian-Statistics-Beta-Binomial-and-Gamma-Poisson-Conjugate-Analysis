# EXERCISE 5: Predictive Distribution for Count Data
# Set seed for reproducibility
set.seed(123)

print("EXERCISE 5: Simulating Predictive Distributions for Count Data")
print(paste(rep("=", 50), collapse = ""))

M <- 10000
n_subjects <- 20

# Function to simulate predictive distribution for Poisson
simulate_poisson_predictive <- function(alpha, beta, M, n) {
  # Draw M samples for λ from Gamma(α, β)
  # Note: β is the rate parameter (1/scale)
  lambda_samples <- rgamma(M, shape = alpha, rate = beta)
  
  # For each λ, draw Poisson counts for n subjects and calculate mean
  y_means <- numeric(M)
  for (m in 1:M) {
    # Draw n Poisson observations and calculate their mean
    counts <- rpois(n, lambda_samples[m])
    y_means[m] <- mean(counts)
  }
  
  return(list(lambda = lambda_samples, y_mean = y_means))
}

# Simulate for two different priors
par(mfrow = c(2, 2))

# Gamma(8, 2) - mean = 8/2 = 4
print("Simulating Gamma(8, 2) prior...")
result1 <- simulate_poisson_predictive(8, 2, M, n_subjects)
plot(density(result1$lambda), main = "Gamma(8, 2) - Prior for λ", 
     xlab = "λ (mean count)", ylab = "Density", col = "blue", lwd = 2)
hist(result1$y_mean, main = "Distribution of Sample Mean", 
     xlab = "Sample Mean of Counts", breaks = 30, 
     col = "lightblue", freq = FALSE)

# Gamma(4, 4) - mean = 4/4 = 1
print("Simulating Gamma(4, 4) prior...")
result2 <- simulate_poisson_predictive(4, 4, M, n_subjects)
plot(density(result2$lambda), main = "Gamma(4, 4) - Prior for λ", 
     xlab = "λ (mean count)", ylab = "Density", col = "green", lwd = 2)
hist(result2$y_mean, main = "Distribution of Sample Mean", 
     xlab = "Sample Mean of Counts", breaks = 30, 
     col = "lightgreen", freq = FALSE)

print("\nPrior specifications and their implications:")
print(paste0("Gamma(8, 2): Mean = ", round(8/2, 2), ", Variance = ", round(8/2^2, 2)))
print("  - Higher mean count expectation (4 events per subject)")
print("  - More concentrated around the mean")
print(paste0("Gamma(4, 4): Mean = ", round(4/4, 2), ", Variance = ", round(4/4^2, 2)))
print("  - Lower mean count expectation (1 event per subject)")
print("  - Less concentrated, allowing for more uncertainty")

# Summary statistics
print("\nSummary of predictive distributions for sample means:")
print(paste0("Gamma(8,2) - Mean: ", round(mean(result1$y_mean), 3), 
             ", SD: ", round(sd(result1$y_mean), 3)))
print(paste0("Gamma(4,4) - Mean: ", round(mean(result2$y_mean), 3), 
             ", SD: ", round(sd(result2$y_mean), 3)))

print("\nObservations on the change in distribution of y:")
print("- Different priors lead to different centers for the predictive distribution")
print("- The Gamma(8,2) prior produces sample means centered around 4")
print("- The Gamma(4,4) prior produces sample means centered around 1")
print("- The spread of the predictive distribution reflects both prior uncertainty and sampling variability")

# Additional analysis: Compare with theoretical expectations
print("\nTheoretical vs. Empirical comparison:")
print("For Gamma(8,2) prior:")
print(paste0("  Theoretical mean of λ: ", 8/2))
print(paste0("  Empirical mean of sample means: ", round(mean(result1$y_mean), 3)))

print("For Gamma(4,4) prior:")
print(paste0("  Theoretical mean of λ: ", 4/4))
print(paste0("  Empirical mean of sample means: ", round(mean(result2$y_mean), 3)))

print("\nConclusion: The predictive distributions correctly reflect the prior beliefs")
print("about the underlying Poisson rate parameter λ.")