data(cars)
cars.lo <- loess(dist ~ speed, cars)
predict(cars.lo, data.frame(speed = seq(5, 30, 1)), se = TRUE)
# to allow extrapolation
cars.lo2 <- loess(dist ~ speed, cars, control = loess.control(surface = "direct"))
predict(cars.lo2, data.frame(speed = seq(5, 30, 1)), se = TRUE)

# and
# http://archive.ics.uci.edu/ml/datasets/Student+Performance
# http://archive.ics.uci.edu/ml/datasets/NoisyOffice
# http://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset
