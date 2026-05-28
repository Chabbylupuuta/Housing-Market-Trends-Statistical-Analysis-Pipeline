# ==============================================================================
# PROJECT: Housing Market Trends & Statistical Analysis Pipeline
# USING REAL DATA FROM real_housing_data.csv
# ==============================================================================

# --- STEP 1: LOAD REQUISITE LIBRARIES ---
library(dplyr)
library(ggplot2)
library(tidyr)
library(lubridate)
library(waterfalls)   # optional, not used directly

# --- STEP 2: READ REAL CSV DATA ---
# Make sure real_housing_data.csv is in your working directory
housing_data <- read.csv("real_housing_data.csv", stringsAsFactors = FALSE)

# Convert Date column to Date type (if it's not already)
housing_data$Date <- as.Date(housing_data$Date)

# Check the data
cat("--- DATA LOADED SUCCESSFULLY ---\n")
print(head(housing_data))
cat("\nTotal Records:", nrow(housing_data), "\n\n")

# --- STEP 3: STATISTICAL EXPLORATION & INFERENCE ---
cat("--- EXECUTING STATISTICAL PROFILE ---\n")
avg_price <- mean(housing_data$MedianPrice, na.rm = TRUE)
sd_price  <- sd(housing_data$MedianPrice, na.rm = TRUE)
price_volatility <- (sd_price / avg_price) * 100

cat("Portfolio Median Price Average: $", round(avg_price, 2), "\n")
cat("Market Volatility Coefficient:  ", round(price_volatility, 2), "%\n")

rate_volume_corr <- cor(housing_data$InterestRate, housing_data$SalesVolume, use = "complete.obs")
cat("Correlation (Interest Rate vs Sales Volume):", round(rate_volume_corr, 4), "\n\n")

# --- STEP 4: PRODUCTION-GRADE GRAPHICS ---
cat("--- RENDERING GRAPHICS TO FILE DIRECTORY ---\n")
dir.create("pictures", showWarnings = FALSE)

# Visual 1: Time Series Trend Line (Median Prices)
p1 <- ggplot(housing_data, aes(x = Date, y = MedianPrice)) +  
  geom_line(color = "#0066cc", size = 1) +  
  labs(title = "Macro Trend: Median Housing Prices Over Time",
       subtitle = "Longitudinal evaluation (2010 - 2020)",
       x = "Fiscal Period", y = "Median Market Price ($)") +  
  theme_minimal()
ggsave("pictures/01_median_price_trends.png", plot = p1, width = 8, height = 5)

# Visual 2: Scatter Evaluation with Linear Model Trend Fit
p2 <- ggplot(housing_data, aes(x = SalesVolume, y = MedianPrice)) +  
  geom_point(color = "#1a365d", alpha = 0.7, size = 2) +  
  geom_smooth(method = "lm", color = "#e53e3e", se = TRUE) +
  labs(title = "Market Velocity Vector",
       subtitle = "Scatter Plot: Median Price vs. Sales Volume with Regression Line",
       x = "Aggregate Sales Volume", y = "Median Price ($)") +  
  theme_minimal()
ggsave("pictures/02_price_vs_volume_scatter.png", plot = p2, width = 8, height = 5)

# Visual 3: Dynamic Regional Apportionment (Donut Chart)
region_summary <- housing_data %>%  
  group_by(Region) %>%  
  summarise(TotalSales = sum(SalesVolume, na.rm = TRUE), .groups = "drop")

p3 <- ggplot(region_summary, aes(x = 2, y = TotalSales, fill = Region)) +  
  geom_bar(stat = "identity", width = 1) +  
  coord_polar(theta = "y") +  
  geom_text(aes(label = paste0(round((TotalSales / sum(TotalSales)) * 100), "%")),             
            position = position_stack(vjust = 0.5), color = "white", fontface = "bold") +  
  scale_fill_brewer(palette = "Set1") +
  theme_void() +  
  xlim(0.5, 2.5) +  
  labs(title = "Regional Sales Volume Market Share") +  
  theme(legend.position = "right")
ggsave("pictures/03_regional_donut_chart.png", plot = p3, width = 6, height = 5)

# Visual 4: Volume Strata Distribution (Histogram)
p4 <- ggplot(housing_data, aes(x = SalesVolume)) +  
  geom_histogram(binwidth = 150, fill = "#718096", color = "white", alpha = 0.9) +  
  labs(title = "Sales Volume Density Profiles",
       x = "Sales Volume Thresholds", y = "Frequency Matrix Mapping") +  
  theme_minimal()
ggsave("pictures/04_sales_volume_histogram.png", plot = p4, width = 8, height = 5)

# Visual 5: Chronological Quantitative Stratification (Area Chart)
p5 <- ggplot(housing_data, aes(x = Date, y = SalesVolume, fill = Region)) +  
  geom_area(alpha = 0.65, size = 0.3, colour = "white") +  
  scale_fill_viridis_d(option = "D") +
  labs(title = "Area Stratification: Regional Sales Volume Over Time",
       x = "Timeline", y = "Cumulative Volume Metrics") +  
  theme_minimal()
ggsave("pictures/05_regional_area_chart.png", plot = p5, width = 8, height = 5)

cat("Execution completed. All high-resolution graphical assets compiled into '/pictures'. ✅\n")
