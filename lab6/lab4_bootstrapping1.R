library(mlbench)
data(BreastCancer)
l <- length(BreastCancer[,1])
sub <- sample(1:l,2*l/3)
BC.bagging <- bagging(Class ~., data=BreastCancer[,-1], mfinal=20, control=rpart.control(maxdepth=3))
BC.bagging.pred <-predict.bagging( BC.bagging, newdata=BreastCancer[-sub,-1])
BC.bagging.pred$confusion
# vary mfinal and maxdepth, compare
# change sampling?
