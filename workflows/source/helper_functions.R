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
merge_dfs <- function(weight_list, warming_list) {

  merged_dfs <- lapply(names(weight_list), function(scenario) {

    # Check if the scenario is present in both lists
    if (scenario %in% names(warming_list)) {

      # Merge the corresponding data frames
      merged_df <- left_join(weight_list[[scenario]], warming_list[[scenario]], by = "run_number")

      return(merged_df)

    } else {
      # If scenario not in warming_results, return the original weight data frame
      return(weight_list[[scenario]])
    }
  })

  names(merged_dfs) <- names(weight_list)

  return(merged_dfs)
}

## Splitting data based on criteria weight combinations
split_data_frame <- function(df) {
  # Check if df is a data frame
  if (!is.data.frame(df)) {
    stop("Input must be a data frame")
  }

  # Check if the required columns exist
  required_cols <- c("temp_wt", "co2_wt", "ocean_uptake_wt")
  if (!all(required_cols %in% names(df))) {
    stop("Data frame must contain the following columns: temp_wt, co2_wt, ocean_uptake_wt")
  }

  # Split the df based on the specified columns
  data <- split(df, list(df$temp_wt, df$co2_wt, df$ocean_uptake_wt), drop = T)

  return(data)
}

# Function to calculate summary statistics, nested by "term" (short, mid, long)
data_summary_test <- function(split_data) {

  # Apply summary calculations for each criteria weight combination
  metric_stats <- lapply(split_data, function(df) {

    # Split further by "term" within each criteria weight combination
    term_split <- split(df, df$term)

    # Compute summary statistics for each term (short, mid, long)
    term_stats <- lapply(term_split, function(term_df) {
      summarize(
        term_df,
        median = weighted.quantile(term_df$metric_result, w = term_df$mc_weight, probs = 0.5),
        lower  = weighted.quantile(term_df$metric_result, w = term_df$mc_weight, probs = 0.05),
        upper  = weighted.quantile(term_df$metric_result, w = term_df$mc_weight, probs = 0.95)
      )
    })

    return(term_stats)

  })

  return(metric_stats)
}

# Error calculation function
compute_error <- function(estimated_value, target_value) {

  # Absolute error
  absolute_error <- abs(estimated_value - target_value)

  # Relative error
  relative_error <- absolute_error / abs(target_value)

  # Percentage error
  percentage_error <- relative_error * 100

  # Make a list storing all the error values
  list(
    absolute_error = absolute_error,
    relative_error = relative_error,
    percentage_error = percentage_error
  )
}
