<div align="center">

# Jordà (2005)
### Local Projections — A Replication in Stata

[![Stata](https://img.shields.io/badge/Language-Stata-1A6496?style=flat-square)]()
[![Method](https://img.shields.io/badge/Method-Local%20Projections-8A2BE2?style=flat-square)]()
[![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=flat-square)]()
[![Journal](https://img.shields.io/badge/Journal-AER%202005-orange?style=flat-square)]()

*Part of the [`replications`](../../../README.md) repository by [Juan Nicolás D'Amico](https://github.com/juan-damico)*

</div>

---

## The Paper

> **Jordà, Ò. (2005).** Estimation and inference of impulse responses by local projections. *American Economic Review*, 95(1), 161–182.

Jordà (2005) proposes Local Projections (LP) as an alternative to the VAR-based approach for estimating impulse response functions. Rather than inverting a fitted VAR model, LPs estimate each horizon of the IRF directly via a sequence of regressions of the outcome variable shifted $h$ periods ahead on a shock and a set of controls.

This replication follows Evans & Marshall (1998) as the empirical application.

---

## 📁 Repository Structure

```bash
local-projections/
├── code/
├── data/
├── figures/
└── jorda-2005.md
```

---

## Data and Variables

| Variable | Description |
|---|---|
| `em` | Employment (log) |
| `p` | Price level (log) |
| `pcom` | Commodity prices (log) |
| `ff` | Federal funds rate |
| `nbrx` | Nonborrowed reserves (log) |
| `m2` | Money supply M2 (log) |

---

## Model Specification

### Step 1 — VAR(12)

$$
\mathbf{y}_t = \mathbf{c} + \sum_{l=1}^{12} \mathbf{A}_l \mathbf{y}_{t-l} + \varepsilon_t
$$

---

### Step 2 — Shock

$$
s_t = \frac{\hat{\varepsilon}_{ff,t}^{\perp}}{\text{sd}(\hat{\varepsilon}_{ff,t}^{\perp})}
$$

---

### Step 3 — Local Projections

$$
y_{i,t+h} = \alpha_{i}^{(h)} + \beta_{i}^{(h)} s_t + \sum_{l=1}^{12} \Gamma_l^{(h)} X_{t-l} + u_{i,t+h}
$$

---

### Step 4 — Comparison

VAR vs LP impulse responses.

---

## Implementation

```stata
ssc install locproj
```

---

## Dataset

Based on Evans & Marshall (1998).  
Full dataset included in `data/`.

---

## Complete Replication Script (Stata DO File)

This repository provides modular code to reproduce each component of the analysis.

For a fully integrated and professionally structured implementation:

[![Buy Complete Stata DO File](https://img.shields.io/badge/Buy-Full%20Do%20File-blue?style=for-the-badge)](https://jdeconomicstore.com/b/local-projections-jorda2005)

*Note: This DO file is my property and is not endorsed by the original authors. It is an independent replication and may present discrepancies relative to the original work.*

---

## Citation

```bibtex
@article{jorda2005estimation,
  title={Estimation and inference of impulse responses by local projections},
  author={Jord{\`a}, Oscar},
  journal={American Economic Review},
  year={2005}
}
```

---

## Disclaimer

Independent replication. Not endorsed by original authors.

---

<div align="center">

*← Back to [`replications`](../../../README.md)*

</div>
