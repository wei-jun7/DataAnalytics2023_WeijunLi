library(ipred)
data(Ozone)
l <- length(Ozone[,1])
sub <- sample(1:l,2*l/3)
OZ.bagging <- bagging(V4 ~., data=Ozone[,-1], mfinal=30, control=rpart.control(maxdepth=5))
OZ.bagging.pred <-predict.bagging( OZ.bagging, newdata=Ozone[-sub,-4])
OZ.bagging.pred$confusion

