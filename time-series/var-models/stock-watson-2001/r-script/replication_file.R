# =============================================================================
# Replication of Stock & Watson (2001): Vector Autoregressions
# Journal of Economic Perspectives, 15(4), 101-115
# =============================================================================
#
# Author:  Juan Nicolas D'Amico
# Contact: juan.damico@forecastingeconomics.com
# Date:    2026
#
# Description:
#   This script replicates the impulse-response functions reported in Figure 1
#   of Stock & Watson (2001), using a three-variable recursive VAR estimated
#   on U.S. quarterly data (1960:Q1-2000:Q4).
#
# Disclaimer:
#   This code has been independently developed by Juan D'Amico for educational
#   and research purposes. The original paper and its contents belong to the
#   respective authors. This replication is not affiliated with or endorsed by
#   Stock & Watson or the American Economic Association.
#
# =============================================================================


# Import Libraries and dataset
library(readr)
library(vars)

data      <- read_csv("stock_watson_dataset.csv")
y         <- data[, c("infl", "unrate", "fedfunds")]


#Estimate the reduced form VAR model and print the summary of results
var_model <- VAR(y, p = 4, type = "const")
summary(var_model)

#Compute the Impulse response functions using a recursive ordering

irf_all <- irf(
  var_model,
  n.ahead = 24,
  ortho   = TRUE,
  boot    = TRUE,
  ci      = 0.68,
  runs    = 500,
  seed    = 123
)


# Create labels and format the image to reflect the published paper

# Labels
var_labels <- c(
  infl     = "Inflation",
  unrate   = "Unemployment",
  fedfunds = "Interest Rate"
)

par(
  mfrow    = c(3, 3),
  mar      = c(4, 4.5, 3.5, 1),
  oma      = c(0, 0, 4, 0),
  cex.main = 0.90,
  cex.lab  = 0.85,
  cex.axis = 0.78,
  font.main = 1
)

variables <- colnames(y)

for (imp in variables) {
  for (resp in variables) {
    
    irf_vals <- irf_all$irf[[imp]][, resp]
    lower    <- irf_all$Lower[[imp]][, resp]
    upper    <- irf_all$Upper[[imp]][, resp]
    
    imp_label  <- var_labels[imp]
    resp_label <- var_labels[resp]
    
    plot(
      0:24, irf_vals,
      type = "l",
      lwd  = 1.8,
      ylim = range(lower, upper),
      main = paste0(imp_label, " Shock to\n", resp_label),  # formato S&W
      ylab = "Percent",
      xlab = "Lag",
      col  = "black",
      axes = FALSE
    )
    
    axis(1, at = seq(0, 24, by = 4))
    axis(2, las = 1)
    box()
    
    lines(0:24, lower, lty = 2, lwd = 1.0, col = "gray40")
    lines(0:24, upper, lty = 2, lwd = 1.0, col = "gray40")
    abline(h = 0, col = "black", lwd = 0.6)
  }
}

mtext(
  "Impulse Responses in the Inflation-Unemployment-Interest Rate Recursive VAR",
  outer = TRUE,
  cex   = 0.95,
  font  = 2,
  line  = 1.5
)