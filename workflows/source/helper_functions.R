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

# Function to merge lists

# Ensure that each data frame has the 'run_number' column
check_run_number_column <- function(df) {
  if (!"run_number" %in% colnames(df)) {
    stop("The 'run_number' column is missing in one of the data frames.")
  }
  return(df)
}

# Define a function to merge the data frames from warming_result and wts
# Function to merge data frames
merge_dfs <- function(weight_dfs, warming_dfs) {

  merged_dfs <- lapply(names(weight_dfs), function(scenario) {

    # Check if the scenario is present in both lists
    if (scenario %in% names(warming_dfs)) {

      # Merge the corresponding data frames
      merged_df <- left_join(weight_dfs[[scenario]], warming_dfs[[scenario]], by = "run_number")

      return(merged_df)

    } else {
      # If scenario not in warming_results, return the original weight data frame
      return(weight_dfs[[scenario]])
    }
  })

  names(merged_dfs) <- names(weight_dfs)

  return(merged_dfs)
}

# Compute data summary (median and 5-95% CI)

data_summary_single_df <- function(df) {

  # Calculate weighted quantiles for the metric_result column
    metric_stats <-
      df %>%
      summarize(
        median = weighted.quantile(metric_result, w = weights, probs = 0.5),
        lower = weighted.quantile(metric_result, w = weights, probs = 0.05),
        upper = weighted.quantile(metric_result, w = weights, probs = 0.95)
      )

    return(metric_stats)
  }
