require(mlbench)
data(HouseVotes84)
library(klaR)
model <- NaiveBayes(Class ~ ., data = HouseVotes84)
predict(model, HouseVotes84[1:10,-1])

pred <- predict(model, HouseVotes84[,-1])
table(pred$class, HouseVotes84$Class)
