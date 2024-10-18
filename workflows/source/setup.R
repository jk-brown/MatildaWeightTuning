# setup libraries and other values needed for analysis

# load libraries
library(matilda)
library(tidyverse)
library(spatstat)
library(parallel)
library(ggtern)

# IPCC values
ipcc_119_short <- c(0.61, 0.38, 0.85)
ipcc_119_mid <- c(0.71, 0.40, 1.07)
ipcc_119_long <- c(0.56, 0.24, 0.96)

ipcc_126_short <- c(0.63, 0.41, 0.89)
ipcc_126_mid <- c(0.88, 0.54, 1.32)
ipcc_126_long <- c(0.90, 0.51, 1.48)

ipcc_245_short <- c(0.66, 0.44, 0.90)
ipcc_245_mid <- c(1.12, 0.78, 1.57)
ipcc_245_long <- c(1.81, 1.24, 2.59)

ipcc_370_short <- c(0.67, 0.45, 0.92)
ipcc_370_mid <- c(1.28, 0.92, 1.75)
ipcc_370_long <- c(2.76, 2.00, 3.75)

ipcc_585_short <- c(0.76, 0.51, 1.04)
ipcc_585_mid <- c(1.54, 1.08, 2.08)
ipcc_585_long <- c(3.50, 2.44, 4.82)

ipcc_values <- list(ssp_names[1] = ipcc_119_long,
                    ssp_names[2] = ipcc_126_long,
                    ssp_names[3] = ipcc_245_long,
                    ssp_names[4] = ipcc_370_long,
                    ssp_names[5] = ipcc_585_long)
