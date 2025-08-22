# EXERCISE 4: Phase-2 Single-Arm Trial Analysis
# Set seed for reproducibility
set.seed(123)

print("EXERCISE 4: Analyzing Phase-2 Trial with Binary Endpoint")
print(paste(rep("=", 50), collapse = ""))

# Prior: Beta(8, 12)
prior_alpha <- 8
prior_beta <- 12

# Data: 21 responses out of 45 subjects
y <- 21
n <- 45

# Posterior: Beta(8 + 21, 12 + 45 - 21)
post_alpha <- prior_alpha + y
post_beta <- prior_beta + n - y

print(paste0("Prior: Beta(", prior_alpha, ", ", prior_beta, ")"))
print(paste0("Data: ", y, " responses out of ", n, " subjects"))
print(paste0("Posterior: Beta(", post_alpha, ", ", post_beta, ")"))

# Draw 10,000 samples from posterior
posterior_samples <- rbeta(10000, post_alpha, post_beta)

# (i) Calculate summaries
mean_post <- mean(posterior_samples)
median_post <- median(posterior_samples)
ci_post <- quantile(posterior_samples, c(0.025, 0.975))

print("\n(i) Posterior summaries:")
print(paste0("  Mean: ", round(mean_post, 4)))
print(paste0("  Median: ", round(median_post, 4)))
print(paste0("  95% Credible Interval: [", round(ci_post[1], 4), ", ", round(ci_post[2], 4), "]"))

# (ii) Probability that response rate > 0.265 (SoC)
soc_rate <- 0.265
prob_better_than_soc <- mean(posterior_samples > soc_rate)

print("\n(ii) Comparison with Standard of Care:")
print(paste0("  SoC response rate: ", soc_rate))
print(paste0("  P(experimental > SoC) = ", round(prob_better_than_soc, 4)))
print(paste0("  This represents ", round(prob_better_than_soc * 100, 2), 
             "% probability that the experimental drug is better than SoC"))

# Additional analysis
print("\n(iii) Additional posterior probabilities:")
print(paste0("  P(response rate > 0.3) = ", round(mean(posterior_samples > 0.3), 4)))
print(paste0("  P(response rate > 0.4) = ", round(mean(posterior_samples > 0.4), 4)))
print(paste0("  P(response rate > 0.5) = ", round(mean(posterior_samples > 0.5), 4)))

# Visualization
par(mfrow = c(1, 2))

# Plot prior and posterior
x_seq <- seq(0, 1, 0.001)
prior_density <- dbeta(x_seq, prior_alpha, prior_beta)
posterior_density <- dbeta(x_seq, post_alpha, post_beta)

plot(x_seq, prior_density, type = "l", col = "blue", lwd = 2,
     xlab = "Response Rate (π)", ylab = "Density",
     main = "Prior vs Posterior", ylim = c(0, max(c(prior_density, posterior_density))))
lines(x_seq, posterior_density, col = "red", lwd = 2)
abline(v = soc_rate, col = "green", lty = 2)
legend("topright", c("Prior", "Posterior", "SoC"), 
       col = c("blue", "red", "green"), lwd = c(2, 2, 1), lty = c(1, 1, 2))

# Histogram of posterior samples
hist(posterior_samples, breaks = 50, freq = FALSE, 
     main = "Posterior Distribution", xlab = "Response Rate",
     col = "lightblue")
abline(v = soc_rate, col = "green", lty = 2, lwd = 2)
abline(v = mean_post, col = "red", lty = 1, lwd = 2)
legend("topright", c("Posterior Mean", "SoC Rate"), 
       col = c("red", "green"), lty = c(1, 2), lwd = c(2, 2))

print("\nInterpretation:")
print("The posterior distribution shows strong evidence that the experimental")
print("treatment has a higher response rate than the standard of care.")
print(paste0("With ", round(prob_better_than_soc * 100, 1), "% probability of superiority,"))
print("this would likely support advancing to Phase 3 trials.")