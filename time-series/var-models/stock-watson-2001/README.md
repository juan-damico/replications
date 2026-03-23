<div align="center">

# Stock & Watson (2001)
### Vector Autoregressions — A Replication in R

[![R](https://img.shields.io/badge/Language-R-276DC3?style=flat-square&logo=r&logoColor=white)](https://www.r-project.org/)
[![Method](https://img.shields.io/badge/Method-VAR-8A2BE2?style=flat-square)]()
[![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=flat-square)]()
[![Journal](https://img.shields.io/badge/Journal-JEP%202001-orange?style=flat-square)]()

*Part of the [`replications`](../../../README.md) repository by [Juan Nicolás D'Amico](https://github.com/juan-damico)*

</div>

---

## The Paper

> **Stock, J. H., & Watson, M. W. (2001).** Vector autoregressions. *Journal of Economic Perspectives*, 15(4), 101–115.

This paper provides one of the most accessible and widely cited introductions to **Vector Autoregressive (VAR)** models in macroeconomics. Stock & Watson demonstrate how VARs can be used to capture dynamic relationships between multiple time series, forecast macroeconomic variables, and identify structural shocks through impulse-response analysis.

---

## Objective

Replicate the core VAR workflow from Stock & Watson (2001) in R, documenting every step from raw data to impulse-response functions — with enough clarity that the code serves as a standalone learning resource.

---

## Repository Structure

```
stock-watson-2001/
├── data/
│   ├── raw/                    # Original source data
│   └── processed/              # Cleaned, stationary series
├── R/
│   ├── 01_data_prep.R          # Loading, transformations, stationarity tests
│   ├── 02_lag_selection.R      # AIC / BIC / HQ criteria
│   ├── 03_var_estimation.R     # Reduced-form VAR estimation
│   └── 04_irf_analysis.R       # Impulse-response functions + confidence bands
├── figures/
│   └── figure.png              # IRF plots
└── README.md
```

---

## Workflow

```
Raw Data → Stationarity Tests → Lag Selection → VAR Estimation → IRF Analysis → Results
```

### Steps

**1. Data Preparation** — Variable selection, unit root tests (ADF/KPSS), and transformations (log-differences, detrending) to ensure stationarity before estimation.

**2. Lag Selection** — Comparison of information criteria (AIC, BIC, Hannan-Quinn) to determine the optimal lag length for the VAR system.

**3. VAR Estimation** — Estimation of the reduced-form VAR using OLS equation by equation, following the specification in Stock & Watson (2001).

**4. Impulse-Response Analysis** — Computation of orthogonalized IRFs via Cholesky decomposition, with bootstrapped confidence bands. Interpretation of dynamic responses to structural shocks.

---

## Getting Started

### Requirements

```r
install.packages(c("vars", "tseries", "urca", "ggplot2", "dplyr", "readr"))
```

### Run the replication

```r
setwd("R/")

source("01_data_prep.R")
source("02_lag_selection.R")
source("03_var_estimation.R")
source("04_irf_analysis.R")
```

Each script is self-contained and annotated. Run them in order for the full pipeline.

---

## Model Specification

The system consists of three endogenous variables — unemployment rate ($u_t$), inflation ($\pi_t$), and the federal funds rate ($r_t$) — estimated as a VAR(4) with a constant.

### Equation Form

$$u_t = c_1 + \sum_{l=1}^{4} \alpha_{11}^{(l)} u_{t-l} + \sum_{l=1}^{4} \alpha_{12}^{(l)} \pi_{t-l} + \sum_{l=1}^{4} \alpha_{13}^{(l)} r_{t-l} + \varepsilon_{1t}$$

$$\pi_t = c_2 + \sum_{l=1}^{4} \alpha_{21}^{(l)} u_{t-l} + \sum_{l=1}^{4} \alpha_{22}^{(l)} \pi_{t-l} + \sum_{l=1}^{4} \alpha_{23}^{(l)} r_{t-l} + \varepsilon_{2t}$$

$$r_t = c_3 + \sum_{l=1}^{4} \alpha_{31}^{(l)} u_{t-l} + \sum_{l=1}^{4} \alpha_{32}^{(l)} \pi_{t-l} + \sum_{l=1}^{4} \alpha_{33}^{(l)} r_{t-l} + \varepsilon_{3t}$$

### Matrix Form

$$
\begin{aligned}
\begin{pmatrix}
u_t\\
\pi_t\\
r_t
\end{pmatrix}
&=
\begin{pmatrix}
c_1\\
c_2\\
c_3
\end{pmatrix}
+
\sum_{l=1}^{4}
\begin{pmatrix}
\alpha_{11}^{(l)} & \alpha_{12}^{(l)} & \alpha_{13}^{(l)} \\
\alpha_{21}^{(l)} & \alpha_{22}^{(l)} & \alpha_{23}^{(l)} \\
\alpha_{31}^{(l)} & \alpha_{32}^{(l)} & \alpha_{33}^{(l)}
\end{pmatrix}
\begin{pmatrix}
u_{t-l}\\
\pi_{t-l}\\
r_{t-l}
\end{pmatrix} \\
&\quad +
\begin{pmatrix}
\varepsilon_{1t}\\
\varepsilon_{2t}\\
\varepsilon_{3t}
\end{pmatrix}.
\end{aligned}
$$

where $\boldsymbol{\varepsilon}_t \sim \mathcal{N}(\mathbf{0}, \boldsymbol{\Sigma})$ and $\boldsymbol{\Sigma}$ is a $3 \times 3$ positive definite covariance matrix.
### Compact Form

$$\mathbf{y}_t = \mathbf{c} + \sum_{l=1}^{4} \mathbf{A}_l\, \mathbf{y}_{t-l} + \boldsymbol{\varepsilon}_t, \qquad \boldsymbol{\varepsilon}_t \sim \mathcal{N}(\mathbf{0},\, \boldsymbol{\Sigma})$$

where $\mathbf{y}_t = (u_t,\, \pi_t,\, r_t)'$ is the $3 \times 1$ vector of endogenous variables, $\mathbf{A}_l$ is the $3 \times 3$ coefficient matrix at lag $l$, $\mathbf{c}$ is a $3 \times 1$ vector of intercepts, and $\boldsymbol{\Sigma} = \mathbb{E}[\boldsymbol{\varepsilon}_t \boldsymbol{\varepsilon}_t']$ is the reduced-form covariance matrix.

---

## Results

### Impulse-Response Functions

An impulse-response function (IRF) traces the dynamic effect of a one-unit shock to one variable on all other variables in the system over a given horizon. In a VAR with $n$ variables, there are $n^2$ such response paths — one for each shock-response pair — which together describe the full propagation of shocks through the system.

Because VAR residuals are typically correlated across equations, raw shocks cannot be interpreted as economically meaningful. To recover interpretable structural shocks, the residuals must be orthogonalized. Here, identification is achieved via **Cholesky decomposition** of the residual covariance matrix, which imposes a **recursive causal ordering** on the variables. This is equivalent to a Structural VAR (SVAR) with short-run zero restrictions: variables ordered earlier in the system are assumed to respond to shocks from variables ordered later only with a lag, while variables ordered later can respond contemporaneously to all preceding variables.

The ordering adopted here is: **Unemployment → Inflation → Federal Funds Rate**. This reflects the assumption that the Fed observes both unemployment and inflation within the period before setting the policy rate, while real and price variables do not respond to monetary policy shocks within the same period. The results should be interpreted with this identifying assumption in mind.

![Impulse-Response Functions](figures/figure.png)

*Figure 1: Orthogonalized impulse-response functions from a VAR(4) estimated on the unemployment rate, inflation, and the federal funds rate. Identification via Cholesky decomposition with ordering: unemployment → inflation → federal funds rate. Dashed lines represent 95% bootstrap confidence bands. Horizon measured in quarters. Replication based on Stock & Watson (2001).*

---

## Citation

**Original Paper**
```bibtex
@article{stock2001vector,
  title     = {Vector autoregressions},
  author    = {Stock, James H and Watson, Mark W},
  journal   = {Journal of Economic Perspectives},
  volume    = {15},
  number    = {4},
  pages     = {101--115},
  year      = {2001},
  publisher = {American Economic Association}
}
```

**This Replication**
```bibtex
@misc{damico2026replications,
  author       = {D'Amico, Juan Nicolas},
  title        = {Replication of Stock and Watson (2001): Vector Autoregressions},
  year         = {2026},
  howpublished = {\url{https://github.com/juan-damico/replications}},
  note         = {GitHub repository}
}
```

---

## Disclaimer

This is an independent replication developed by Juan D'Amico for educational and research purposes, and is not affiliated with or endorsed by the original authors. Discrepancies from the original paper may arise due to data availability, software differences, or interpretation choices. Please cite both the original paper and this repository if you use this work.

---

<div align="center">

*← Back to [`replications`](../../../README.md)*

</div>
