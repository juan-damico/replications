<div align="center">

# 📊 Econometric Replications

### Reproducible implementations of landmark papers in macroeconometrics

[![R](https://img.shields.io/badge/Language-R-276DC3?style=flat-square&logo=r&logoColor=white)](https://www.r-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=flat-square)]()
[![Replications](https://img.shields.io/badge/Papers%20Replicated-1-blue?style=flat-square)]()

*By [Juan Nicolás D'Amico](https://github.com/juan-damico) · For educational and research purposes*

</div>

---

## Overview

This repository contains rigorous, self-contained replications of influential econometrics papers, with an emphasis on **clarity**, **reproducibility**, and **pedagogical value**. Each replication follows the original methodology as closely as possible, with transparent documentation of any deviations.

> **Audience:** Graduate students, researchers, and practitioners looking for well-documented reference implementations.

---

## 📁 Replications

| # | Paper | Method | Language | Status |
|---|-------|--------|----------|--------|
| 01 | [Stock & Watson (2001)](#-stock--watson-2001) | Vector Autoregressions (VAR) | R | ✅ Complete |

---

## 📄 Stock & Watson (2001)

> *Vector Autoregressions* — Journal of Economic Perspectives, 15(4), 101–115.

### What this replication covers

This folder provides a step-by-step R implementation of the VAR framework introduced in Stock & Watson (2001), one of the most cited introductions to vector autoregressive modeling in macroeconomics.

```
stock-watson-2001/
├── data/               # Raw and processed datasets
├── R/
│   ├── 01_data_prep.R         # Data loading and transformation
│   ├── 02_var_estimation.R    # VAR model estimation
│   ├── 03_lag_selection.R     # Information-criterion lag selection
│   └── 04_irf_analysis.R      # Impulse-response function analysis
├── output/
│   ├── figures/               # IRF plots and diagnostics
│   └── tables/                # Coefficient and test result tables
└── README.md                  # Paper-specific documentation
```

### Workflow

```
Raw Data  →  Preparation  →  Lag Selection  →  VAR Estimation  →  IRF Analysis  →  Results
```

**Steps implemented:**

1. **Data preparation** — variable selection, stationarity checks, transformations
2. **Lag selection** — AIC / BIC / HQ criteria comparison
3. **VAR estimation** — reduced-form system estimation
4. **Impulse-response analysis** — orthogonalized IRFs with confidence bands
5. **Interpretation** — structured discussion of results vs. original paper

---

## 🚀 Getting Started

### Prerequisites

```r
# Required packages
install.packages(c("vars", "tseries", "ggplot2", "dplyr", "readr"))
```

### Run a replication

```r
# Clone the repo
# git clone https://github.com/juan-damico/replications.git

# Navigate to the replication
setwd("stock-watson-2001/R")

# Run in order
source("01_data_prep.R")
source("02_var_estimation.R")
source("03_lag_selection.R")
source("04_irf_analysis.R")
```

---

## 📚 Citation

If you use this repository, please cite both the **original paper** and **this repository**:

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

**This Repository**
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

## ⚠️ Disclaimer

This repository contains **independent replications** developed by Juan D'Amico for educational and research purposes. It is not affiliated with or endorsed by any original author.

While every effort is made to faithfully follow the original methodology, discrepancies may arise due to differences in data availability, software versions, or interpretation. This work is not a substitute for the original papers.

---

## 📬 Contact & Contributions

Found an error or have a suggestion? Open an [issue](https://github.com/juan-damico/replications/issues) or submit a pull request. Contributions that improve accuracy, clarity, or coverage are welcome.

---

<div align="center">

*Made with rigor and care · Juan Nicolás D'Amico · 2026*

</div>
