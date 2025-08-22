# EXERCISE 2: Comparing Beta Distribution Summary Statistics
# Set seed for reproducibility
set.seed(123)

print("EXERCISE 2: Comparing Summary Statistics for Beta(4, 6)")
print(paste(rep("=", 50), collapse = ""))

alpha <- 4
beta <- 6

# Method (a): Direct calculation from known expressions
mean_theoretical <- alpha / (alpha + beta)
var_theoretical <- (alpha * beta) / ((alpha + beta)^2 * (alpha + beta + 1))

print("Method (a) - Theoretical calculations:")
print(paste0("  Mean = ", round(mean_theoretical, 6)))
print(paste0("  Variance = ", round(var_theoretical, 6)))

# Method (b): Empirical calculation from samples
samples_beta_4_6 <- rbeta(10000, alpha, beta)
mean_empirical <- mean(samples_beta_4_6)
var_empirical <- var(samples_beta_4_6)

print("\nMethod (b) - Empirical calculations from 10,000 samples:")
print(paste0("  Mean = ", round(mean_empirical, 6)))
print(paste0("  Variance = ", round(var_empirical, 6)))

# Comparison
print("\nComparison:")
print(paste0("  Mean difference: ", round(abs(mean_theoretical - mean_empirical), 6)))
print(paste0("  Variance difference: ", round(abs(var_theoretical - var_empirical), 6)))
print("\nConclusion: Large sample approximation closely matches theoretical values,")
print("confirming that random sampling provides accurate estimates of distribution properties.")

# Optional: Visualize the distribution
par(mfrow = c(1, 1))
hist(samples_beta_4_6, breaks = 50, freq = FALSE, 
     main = "Beta(4, 6) Distribution", 
     xlab = "Proportion (π)", 
     ylab = "Density",
     col = "lightblue")

# Add theoretical density curve
x_seq <- seq(0, 1, 0.001)
lines(x_seq, dbeta(x_seq, alpha, beta), col = "red", lwd = 2)

# Add vertical lines for mean
abline(v = mean_theoretical, col = "red", lty = 2, lwd = 2)
abline(v = mean_empirical, col = "blue", lty = 2, lwd = 2)

legend("topright", 
       c("Theoretical Density", "Theoretical Mean", "Empirical Mean"), 
       col = c("red", "red", "blue"), 
       lty = c(1, 2, 2), 
       lwd = c(2, 2, 2))