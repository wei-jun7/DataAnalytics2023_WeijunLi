#Support Vector Machine (SVM) example using iris dataset
data("iris")
head(iris) # inspecting the first six rows of the dataset
str(iris) # structure of the dataset
library(ggplot2)
library(e1071)
qplot(Petal.Length, Petal.Width, data=iris, color = Species)

help("svm")
svm_model1 <- svm(Species~., data = iris)


summary(svm_model1)

Petal.Length
plot(svm_model1, data = iris,
     Petal.Width~Petal.Length, slice =
       list(Sepal.Width = 3, Sepal.Length = 4))

pred1 <- predict(svm_model1, iris)
table1

table1 <- table(Predicted = pred1, Actual = iris$Species)
table1

Model1_accuracyRate = sum(diag(table1))/sum(table1)
Model1_accuracyRate
# We can calcuate the missclassification rate
Model1_MissClassificationRate = 1 - Model1_accuracyRate
Model1_MissClassificationRate

svm_model2 <- svm(Species~., data = iris, kernel = "linear")
summary(svm_model2)


plot(svm_model2, data = iris,Petal.Width~Petal.Length, slice = list(Sepal.Width = 3,Sepal.Length = 4))

plot(svm_model2, data = iris, Petal.Width~Petal.Length, slice = list(Sepal.Width = 3, Sepal.Length = 4))


pred2 <- predict(svm_model2, iris)
# creating a table using the predicted one and the actual irisdataset
table2 <- table(Predicted = pred2, Actual = iris$Species)
table2


#We can calculate the model2 accuracy
Model2_accuracyRate = sum(diag(table2))/sum(table2)
Model2_accuracyRate
# We can calcuate the missclassification rate
Model2_MissClassificationRate = 1 - Model2_accuracyRate
Model2_MissClassificationRate

