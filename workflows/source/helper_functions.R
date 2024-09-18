## Helper Functions

# Normalizing data to reference period
normalize_to_reference <- function(data, var, ref_start, ref_end) {

  # Filter data for the reference period
  ref_period <- subset(
    data,
    variable == var &
    year >= ref_start &
      year <= ref_end
  )

  # Calculate the mean for the reference period
  mean_ref_dat <- mean(ref_period$value, na.rm = TRUE)

  # Normalize values by subtracting the mean_ref_period
  norm_dat <- data$value - mean_ref_dat

  # Return the normalized data
  return(norm_dat)
}

# Compute data summary (median and 5-95% CI)

# data_summary <- function(data){
#
#   gsat_metric_stats <-
#     data %>%
#     group_by(scenario) %>%
#     summarize(
#       median = weighted.quantile(metric_result, w = norm_weight, probs = 0.5),
#       lower = weighted.quantile(metric_result, w = norm_weight, probs = 0.05),
#       upper = weighted.quantile(metric_result, w = norm_weight, probs = 0.95),
#       .groups = "drop")
#
#   return(gsat_metric_stats)
#
# }
