# **Bayesian Statistics: Beta-Binomial and Gamma-Poisson Conjugate Analysis**

**Overview**
This repository contains R code for HBS-3 Bayesian Statistics pre-workshop exercises focusing on conjugate prior-posterior relationships. The analysis demonstrates:
* Beta-Binomial conjugacy for binary endpoints
* Gamma-Poisson conjugacy for count data
* Prior specification and interpretation
* Predictive distribution simulation
* Clinical trial Bayesian analysis

**Key Results from Analysis**

**Exercise 1: Beta Prior Distributions**
* **Beta(8,12)**: Informative prior, mean = 0.4, concentrated belief
* **Beta(4,6)**: Weakly informative prior, mean = 0.4, moderate uncertainty  
* **Beta(2,2)**: Slightly informative prior, mean = 0.5, uniform-like
* **Beta(1,1)**: Non-informative uniform prior
* **Beta(0.5,0.5)**: Jeffreys prior, U-shaped distribution

**Exercise 2: Theoretical vs Empirical Validation**
* **Theoretical Mean**: 0.400000
* **Empirical Mean**: 0.399876 (10,000 samples)
* **Difference**: < 0.001 (0.1% accuracy)
* **Conclusion**: Monte Carlo approximation excellently matches theory

**Exercise 4: Phase-2 Clinical Trial Results**
* **Prior**: Beta(8,12) - 40% expected response rate
* **Data**: 21 responses out of 45 subjects (46.7% observed)
* **Posterior**: Beta(29,36)

**Primary Outcome**
* **Posterior Mean**: 0.446 (44.6% response rate)
* **95% Credible Interval**: [0.328, 0.568]
* **P(Treatment > Standard Care)**: 99.74%
* **Standard of Care Rate**: 26.5%
* **Clinical Decision**: Strong evidence supporting Phase 3 advancement

**Exercise 5: Count Data Analysis**

| **Prior** | **Mean** | **Variance** | **Interpretation** |
|-----------|----------|--------------|-------------------|
| Gamma(8,2) | 4.0 | 2.0 | Higher count expectation |
| Gamma(4,4) | 1.0 | 0.25 | Lower count expectation |

**Repository Structure**

```
bayesian-statistics-exercises/
│
├── README.md
├── solutions/
│   ├── exercise_1_beta_priors.R          # Beta distribution analysis
│   ├── exercise_2_beta_comparison.R      # Theoretical vs empirical
│   ├── exercise_3_predictive_binary.R    # Predictive distributions
│   ├── exercise_4_phase2_trial.R         # Clinical trial analysis
│   └── exercise_5_count_data.R           # Gamma-Poisson modeling
├── outputs/
│   ├── plots/
│   │   ├── beta_distributions.png
│   │   ├── predictive_comparison.png
│   │   ├── posterior_analysis.png
│   │   └── gamma_poisson.png
│   └── results/
│       └── numerical_summaries.txt
└── docs/
    └── exercise_instructions.pdf
```

**Requirements**

**R Packages**
* `ggplot2` - Advanced plotting and visualization
* `gridExtra` - Multiple plot arrangements

**Installation**

```r
install.packages(c("ggplot2", "gridExtra"))
```

**Simulation Parameters**

| **Parameter** | **Value** | **Description** |
|---------------|-----------|-----------------|
| n_samples | 10,000 | Monte Carlo sample size |
| n_trials | 12 | Binomial trial size (Exercise 3) |
| n_subjects | 20 | Poisson observation count (Exercise 5) |
| prior_alpha | Various | Beta/Gamma shape parameter |
| prior_beta | Various | Beta/Gamma rate parameter |

**Key Features**

1. **Conjugate Analysis**: Leverages Beta-Binomial and Gamma-Poisson conjugacy
2. **Monte Carlo Simulation**: 10,000 samples for accurate approximation
3. **Clinical Application**: Real Phase-2 trial decision making
4. **Visualization**: Comprehensive density plots and histograms
5. **Statistical Validation**: Theoretical vs empirical comparisons

**Conjugate Prior-Posterior Relationships**

**Beta-Binomial Conjugacy**
```
Prior: π ~ Beta(α, β)
Likelihood: y ~ Binomial(n, π)  
Posterior: π|y ~ Beta(α + y, β + n - y)
```

**Gamma-Poisson Conjugacy**
```
Prior: λ ~ Gamma(α, β)
Likelihood: y ~ Poisson(λ)
Posterior: λ|y ~ Gamma(α + Σy, β + n)
```

**How to Run**

```r
# Set working directory
setwd("path/to/bayesian-statistics-exercises")

# Run all exercises
source("solutions/exercise_1_beta_priors.R")
source("solutions/exercise_2_beta_comparison.R") 
source("solutions/exercise_3_predictive_binary.R")
source("solutions/exercise_4_phase2_trial.R")
source("solutions/exercise_5_count_data.R")
```

**Statistical Formulas**

**Beta Distribution Properties**
* Mean: E[π] = α/(α + β)
* Variance: Var[π] = αβ/[(α + β)²(α + β + 1)]

**Gamma Distribution Properties**  
* Mean: E[λ] = α/β (rate parameterization)
* Variance: Var[λ] = α/β²

**Reproducibility**
All analyses use `set.seed(123)` for consistent results across runs. The Monte Carlo simulations will produce identical numerical outputs.

**Educational Value**
This repository demonstrates:
* Proper Bayesian workflow implementation
* Conjugate prior selection and interpretation  
* Clinical trial decision making under uncertainty
* Monte Carlo method validation
* Predictive distribution generation
* Prior sensitivity analysis

**Required Reading**
Spiegelhalter DJ, Abrams KR, Miles JP. *Bayesian Approaches to Clinical Trials and Health-Care Evaluation*. Wiley, 2004. Chapters 1-2, Sections 3.5-3.6.

**License**
This code is provided for educational purposes. Feel free to use and modify for teaching or learning Bayesian statistics concepts.
