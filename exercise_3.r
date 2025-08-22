# EXERCISE 3: Predictive Distribution for Binary Endpoint
# Set seed for reproducibility
set.seed(123)

print("EXERCISE 3: Simulating Predictive Distributions")
print(paste(rep("=", 50), collapse = ""))

M <- 10000
n <- 12

# Function to simulate predictive distribution
simulate_predictive <- function(alpha, beta, M, n) {
  # Draw M samples for π
  pi_samples <- rbeta(M, alpha, beta)
  
  # For each π, draw a binomial variable
  y_samples <- numeric(M)
  for (m in 1:M) {
    y_samples[m] <- rbinom(1, n, pi_samples[m])
  }
  
  return(list(pi = pi_samples, y = y_samples))
}

# Simulate for three different priors
par(mfrow = c(3, 2))

# Beta(4, 6) - original from Exercise 2
print("Simulating Beta(4, 6) prior...")
result1 <- simulate_predictive(4, 6, M, n)
plot(density(result1$pi), main = "Beta(4, 6) - Prior for π", 
     xlab = "π", ylab = "Density", col = "blue", lwd = 2)
hist(result1$y, main = "Predictive Distribution for y", 
     xlab = "Number of successes (y)", breaks = 0:12, 
     col = "lightblue", freq = FALSE)

# Beta(2, 2) - less informative
print("Simulating Beta(2, 2) prior...")
result2 <- simulate_predictive(2, 2, M, n)
plot(density(result2$pi), main = "Beta(2, 2) - Prior for π", 
     xlab = "π", ylab = "Density", col = "green", lwd = 2)
hist(result2$y, main = "Predictive Distribution for y", 
     xlab = "Number of successes (y)", breaks = 0:12, 
     col = "lightgreen", freq = FALSE)

# Beta(1, 1) - non-informative
print("Simulating Beta(1, 1) prior...")
result3 <- simulate_predictive(1, 1, M, n)
plot(density(result3$pi), main = "Beta(1, 1) - Prior for π", 
     xlab = "π", ylab = "Density", col = "red", lwd = 2)
hist(result3$y, main = "Predictive Distribution for y", 
     xlab = "Number of successes (y)", breaks = 0:12, 
     col = "lightcoral", freq = FALSE)

# Print summary statistics for each predictive distribution
print("\nSummary of predictive distributions:")
print(paste0("Beta(4,6) - Mean: ", round(mean(result1$y), 2), 
             ", SD: ", round(sd(result1$y), 2)))
print(paste0("Beta(2,2) - Mean: ", round(mean(result2$y), 2), 
             ", SD: ", round(sd(result2$y), 2)))
print(paste0("Beta(1,1) - Mean: ", round(mean(result3$y), 2), 
             ", SD: ", round(sd(result3$y), 2)))

print("\nObservations on predictive distributions:")
print("- Beta(4,6): Predictive distribution concentrated around 4-5 successes")
print("- Beta(2,2): More spread, centered around 6 successes")
print("- Beta(1,1): Uniform prior leads to most spread predictive distribution")
print("- As priors become less informative, predictive distributions become more spread out")