
# Define criteria range
criteria_seq <- seq(0, 1, by = 0.05)

# Create a full factorial grid of criteria1, criteria2, and criteria3
grid_data <- expand.grid(
  criteria1 = criteria_seq,
  criteria2 = criteria_seq,
  criteria3 = criteria_seq
) %>%
  mutate(proximity = runif(nrow(.)))  # Replace this with your actual proximity data

# Convert criteria1, criteria2, and criteria3 to factors for plotting
grid_data$criteria1 <- factor(grid_data$criteria1, levels = criteria_seq)
grid_data$criteria2 <- factor(grid_data$criteria2, levels = criteria_seq)
grid_data$criteria3 <- factor(grid_data$criteria3, levels = criteria_seq)

# Plot heatmap with facets for different criteria3 values
ggplot(grid_data, aes(x = criteria1, y = criteria2, fill = proximity)) +
  geom_tile() +
  scale_fill_gradient(low = "blue", high = "red") +
  labs(x = 'Criteria 1', y = 'Criteria 2', fill = 'Proximity') +
  facet_wrap(~ criteria3, labeller = label_both) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
