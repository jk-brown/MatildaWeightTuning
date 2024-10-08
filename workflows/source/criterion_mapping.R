## Prepping criterion data and uncertainty for this analysis

### Building new criterion

## Creating new criteria for temperature and ocean carbon uptake.
## Ocean C uptake does not currently have a programmed criteria in Matilda and needs to be created.
## Temperature (GMST) needs to be updated to include data from 1850:2024 -- the current GMST criterion is from 1950:2021.

## Temperature criterion
temp_data <- read.csv("raw_data/gmst_anomaly_hadcrut5.csv")
criterion_temp <- new_criterion("gmst", years = temp_data$year, obs_values = temp_data$value)

## Ocean carbon uptake criterion
ocean_uptake_data <- read.csv("raw_data/annual_ocean_c_uptake.csv")
criterion_ocean_uptake <- new_criterion("ocean_uptake", years = ocean_uptake_data$year, obs_values = ocean_uptake_data$value)

## remove the data from global environment to avoid confusion
rm(temp_data)
rm(ocean_uptake_data)

### Adding uncertainty vectors for time-varying error

## Uncertainty values for criteria
## This data allows for time-varying error

## Global Mean Surface Temperature
# Load GMST uncertainty data
gmst_unc <- read.csv("raw_data/annual_gmst_SD_quant.csv")

# vector of uncertainty values
gmst_unc <- gmst_unc$value

## Atmospheric CO2 Concentration
# CO2 conc uncertainty
co2_unc <- 0.12

## Ocean C Sink
# ocean_uptake uncertainty
ocean_uptake_unc <- 0.4
