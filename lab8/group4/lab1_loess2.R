require(graphics)

plot(cars, main = "lowess(cars)")
lines(lowess(cars), col = 2)
lines(lowess(cars, f = .2), col = 3)
legend(5, 120, c(paste("f = ", c("2/3", ".2"))), lty = 1, col = 2:3)

# and
# http://archive.ics.uci.edu/ml/datasets/Student+Performance
# http://archive.ics.uci.edu/ml/datasets/NoisyOffice
# http://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset
