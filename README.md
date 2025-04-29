# Sequential Probability Ratio Test (SPRT) — Gaussian Case

This project implements a numerical solution to the performance analysis of the SPRT for testing a Gaussian mean, following the method described in Moustakides et al. (2011). It was completed as part of MATH 538 — Sequential Analysis at Binghamton University.

## 📊 Summary

We analyze the performance of SPRT under different error probabilities (α₀, α₁) and compute:

- Wald's approximate decision boundaries
- Operating Characteristics (OC)
- Average Sample Number (ASN) curves for θ ∈ [0, 0.5]
- Comparison with fixed-sample Neyman–Pearson test

## 🧮 Methods

- Solves integral equations governing OC(θ) and ASN(θ) using piecewise constant collocation
- Uses Gaussian-against-Gaussian likelihood ratios
- Plots ASN(θ) under different α configurations

## 📁 Files

- `sprt_simulation.R`: R script to compute ASN numerically
- `report.pdf`: Written summary with figures and interpretation
- `m538_project_description.pdf`: Assignment prompt

## 🔗 References

- Moustakides, G. V., Polunchenko, A. S., & Tartakovsky, A. G. (2011). *A numerical approach to performance analysis of quickest change-point detection procedures*. Statistica Sinica.
- Wald, A. (1947). *Sequential Analysis*. Wiley.

## 👤 Author

**Xi Li**  

