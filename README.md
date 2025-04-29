# SPRT Gaussian Simulation (Sequential Analysis)

This R script numerically solves the integral equations for computing the Average Sample Number (ASN) of a Sequential Probability Ratio Test (SPRT), using the collocation method proposed by Moustakides et al. (2011). It was developed as part of a graduate-level Sequential Analysis course.

## Features
- Computes Wald's decision boundaries based on desired type I/II error
- Numerically computes ASN(θ) across θ ∈ [0, 0.5]
- Plots ASN curves under different (α₀, α₁) setups

## Theory
The implementation is based on solving renewal-type Fredholm integral equations numerically for the Gaussian-vs-Gaussian scenario.

## Author
Xi Li

