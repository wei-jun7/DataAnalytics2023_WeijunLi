install.packages("randomForest")
library(randomForest)
data<-read.csv(file.choose() )# Set the new column names
new_column_names <- c("buying", "maint", "doors", "persons", "lug_boot", "safety","Condition")

# Replace the column names
colnames(data) <- new_column_names
head(data)

str(data)
levels(data$Condition)
summary(data)
set.seed(100)
train <-sample(nrow(data),0.7*nrow(data),replace=FALSE)
TrainSet<-data[train,]
ValidSet<-data[-train,]
summary(TrainSet)
summary(ValidSet)

help("randomForest")
model1 <-randomForest(Condition~.,data=TrainSet,importance=TRUE)
model1
model2 <-randomForest(Condition~.,data=TrainSet,ntree=500,mtry=6,importance=TRUE)

