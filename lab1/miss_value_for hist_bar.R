# Create a histogram with missing values
data <- c(1, 2, 3, NA, 4, 5)
hist(data)
# Create a bar chart with missing values
data <- c("A", "B", "C", NA, "D", "E")
barplot(table(data))
# Calculate the mean with NAs in the data
data <- c(1, 2, NA, 4, 5)
mean_result <- mean(data, na.rm = TRUE)
# The result will be the mean of (1, 2, 4, 5), which is 3
# Calculate the sum with NAs in the data
data <- c(1, 2, NA, 4, 5)
sum_result <- sum(data, na.rm = TRUE)
# The result will be the sum of (1, 2, 4, 5), which is 12
