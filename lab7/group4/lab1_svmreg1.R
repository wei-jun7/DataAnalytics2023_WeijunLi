library(e1071)

> library(e1071)
> data(Ozone, package="mlbench")
> ## split data into a train and test set
> index     <- 1:nrow(Ozone)
> testindex <- sample(index, trunc(length(index)/3))
> testset   <- na.omit(Ozone[testindex,-3])
> trainset  <- na.omit(Ozone[-testindex,-3])
> ## svm
> svm.model <- svm(V4 ~ ., data = trainset, cost = 1000, gamma = 0.0001)
> svm.pred  <- predict(svm.model, testset[,-3])
> crossprod(svm.pred - testset[,3]) / length(testindex)

# and
# http://archive.ics.uci.edu/ml/datasets/Student+Performance
# http://archive.ics.uci.edu/ml/datasets/NoisyOffice
# http://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset
