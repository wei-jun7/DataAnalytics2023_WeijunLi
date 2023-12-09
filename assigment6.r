library(stats)
library(ggplot2)
library(boot)
library(randomForest)
library(caret)
library(kknn)
library(cluster)
library(factoextra)
library(e1071)
library(mclust)
library(rpart)
library(cluster)
library(factoextra)


#read the data
data <- read.csv("HHS_COVID-19_Monthly_Outcome_Survey_-_Wave_28.csv", sep = ",", header = TRUE)
#see the distribution of the data features

jpeg('income disturbation.jpeg', width = 800, height = 600, units = "px", pointsize = 12, quality = 100, bg = "white", res = NA)

hist(data$income, main = "Income Distribution", xlab = "Income", ylab = "Frequency", col = "light blue", border = "red", breaks = c(1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5), label = TRUE)

dev.off()

jpeg('education.jpeg', width = 800, height = 600, units = "px", pointsize = 12, quality = 100, bg = "white", res = NA)

hist(data$ppeducat, main = "Education Distribution", xlab = "Education", ylab = "Frequency", col = "light blue", border = "red", breaks = c(0.5, 1.5, 2.5, 3.5,4.5), label = TRUE)

dev.off()

jpeg('insurance.jpeg', width = 800, height = 600, units = "px", pointsize = 12, quality = 100, bg = "white", res = NA)

insurance_data <- subset(data, CV8a != -99)

hist(insurance_data$CV8a, main = "Insurance Distribution", xlab = "Insurance", ylab = "Frequency", col = "light blue", border = "red", breaks = c(0.5, 1.5, 2.5, 3.5,4.5, 5.5,6.5,7.5), label = TRUE)

dev.off()

jpeg('Employment Information.jpeg', width = 800, height = 600, units = "px", pointsize = 12, quality = 100, bg = "white", res = NA)

clean_employment_data <- subset(data, CV6a_Rec != 2)

hist(clean_employment_data$CV6a_Rec, main = "Employment Information", xlab = "Employment", ylab = "Frequency", col = "light blue", border = "red", breaks = c(  2.5, 3.5,4.5, 5.5,6.5,7.5), label = TRUE)

dev.off()
 




################################################################################
#create the new data set cantain all the dall who have get the vaccine.


data_remove_refused_to_answer <- subset(data, CAM5_VaccUptake != -99)

behavior_data <- subset(data, (CV14_1 != -99 & CV14_1 != -100)& (CV14_2 != -99 & CV14_2 != -100)& (CV14_3 != -99 & CV14_3 != -100)
                        & (CV14_4 != -99 & CV14_4 != -100)&(CAM5_VaccUptake != -99))

income_Education_insurance_employment_data <- subset(data, (CAM5_VaccUptake != -99)&(CV8a !=99)&(CV6a_Rec !=99))

all_feature_data <- subset(data, (CV14_1 != -99 & CV14_1 != -100)& (CV14_2 != -99 & CV14_2 != -100)& (CV14_3 != -99 & CV14_3 != -100)
                        & (CV14_4 != -99 & CV14_4 != -100)&(CAM5_VaccUptake != -99)&(CV8a !=99)&(CV6a_Rec !=99),  )

all_feature_data_without_character <- all_feature_data[sapply(all_feature_data, function(x) !is.character(x))]
jpeg('vaccine uptake.jpeg', width = 800, height = 600, units = "px", pointsize = 12, quality = 100, bg = "white", res = NA)
hist(all_feature_data_without_character$CAM5_VaccUptake, main = "Vaccine Uptake", xlab = "Vaccine Uptake", ylab = "Frequency", col = "light blue", border = "red", breaks = c(-0.5, 0.5, 1.5, 2.5), label = TRUE)
dev.off()

#################################################################################
#PCA analysis



jpeg("pca_with_clean.jpg")

# Assuming that pca_results is the result of running prcomp on your dataset all_features_data
pca_results <- prcomp(all_feature_data_without_character, scale. = TRUE)
prop_var_explained <- pca_results$sdev^2 / sum(pca_results$sdev^2)

# Calculate the cumulative proportion of variance explained
cum_var_explained <- cumsum(prop_var_explained)

# Create a scree plot of the cumulative variance explained
plot(cum_var_explained, xlab = "Number of Principal Components", 
     ylab = "Cumulative Proportion of Variance", 
     type = "b", # for both points and lines
     pch = 19, # type of point
     main = "PCA : Cumulative Variance")

# Add a line at the desired cutoff for explained variance, e.g., 0.8 for 80%
abline(h = 0.8, col = "red", lty = 2)

# Add a label for the plot
mtext("Principle Component Analysis for MOS clean Data", side = 1, line = 4)

dev.off()



##############################################

#Decision Tree
print("=============================================")
print("Decision Tree")

set.seed(133223)


all_feature_data_without_character$CAM5_VaccUptake <- as.factor(all_feature_data_without_character$CAM5_VaccUptake)
levels(all_feature_data_without_character$CAM5_VaccUptake) <- make.names(levels(all_feature_data_without_character$CAM5_VaccUptake))


splitIndex <- createDataPartition(all_feature_data_without_character$CAM5_VaccUptake, p = 0.8, list = FALSE)
train_set <- all_feature_data_without_character[splitIndex, ]
test_set <- all_feature_data_without_character[-splitIndex, ]


control <- trainControl(method = "cv", number = 10, 
                        summaryFunction = multiClassSummary,
                        classProbs = TRUE)


dt_model <- train(CAM5_VaccUptake ~ income + ppeducat + CV8a + CV6a_Rec + CV14_1 + CV14_2 + CV14_3 + CV14_4, 
                  data = train_set, 
                  method = "rpart", 
                  trControl = control)


predictions <- predict(dt_model, newdata = test_set)


test_set$CAM5_VaccUptake <- factor(test_set$CAM5_VaccUptake, levels = levels(train_set$CAM5_VaccUptake))
confusion <- confusionMatrix(predictions, test_set$CAM5_VaccUptake)


print(confusion)


library(rpart.plot)

jpeg("decision_tree.jpg")
rpart.plot(dt_model$finalModel)
dev.off()

print('============================================================')
print("finished the DecisionTree")




#random forest
print("=============================================")
print("Random Forest")

set.seed(123)


#change it to the character data
all_feature_data_without_character$CAM5_VaccUptake <- as.factor(all_feature_data_without_character$CAM5_VaccUptake)
levels(all_feature_data_without_character$CAM5_VaccUptake) <- make.names(levels(all_feature_data_without_character$CAM5_VaccUptake))


splitIndex <- createDataPartition(all_feature_data_without_character$CAM5_VaccUptake, p = 0.8, list = FALSE)
train_set <- all_feature_data_without_character[splitIndex, ]
test_set <- all_feature_data_without_character[-splitIndex, ]


control <- trainControl(method = "cv", number = 10, 
                        summaryFunction = multiClassSummary,
                        classProbs = TRUE)

# make sure best the mtry find out

tuneGrid <- expand.grid(.mtry = c(2, sqrt(ncol(train_set)-1), ncol(train_set)/3))

rf_model <- train(CAM5_VaccUptake ~ ., data = train_set, method = "rf", 
                  trControl = control, tuneGrid = tuneGrid, 
                  ntree = 500, importance = TRUE)


predictions <- predict(rf_model, newdata = test_set)


test_set$CAM5_VaccUptake <- factor(test_set$CAM5_VaccUptake, levels = levels(train_set$CAM5_VaccUptake))


confusion <- confusionMatrix(predictions, test_set$CAM5_VaccUptake)
print(confusion)


jpeg("Random_Forest_mtry.jpg")
plot(rf_model$results$mtry, rf_model$results$Accuracy, type='b', pch=19, col='blue',
     xlab="Number of Randomly Selected Predictors (mtry)", ylab="Accuracy/Cross-Validation")
dev.off()



print('============================================================')
print("finished the Random Forest")

print("=============================================")
print("svm all features")
#svm all factor
all_feature_data_without_character$CAM5_VaccUptake <- as.factor(all_feature_data_without_character$CAM5_VaccUptake)
levels(all_feature_data_without_character$CAM5_VaccUptake) <- make.names(levels(all_feature_data_without_character$CAM5_VaccUptake))


set.seed(123)
splitIndex <- createDataPartition(all_feature_data_without_character$CAM5_VaccUptake, p = 0.8, list = FALSE)
train_set <- all_feature_data_without_character[splitIndex, ]
test_set <- all_feature_data_without_character[-splitIndex, ]


control <- trainControl(method = "cv", number = 10, 
                        summaryFunction = multiClassSummary,
                        classProbs = TRUE)


svm_model_1 <- train(CAM5_VaccUptake ~ ., data = train_set,
                   method = "svmRadial",
                   trControl = trainControl(method = "cv", number = 10, selectionFunction = "best"),
                   preProcess = c("center", "scale", "nzv", "pca"))


predictions <- predict(svm_model_1, newdata = test_set)


test_set$CAM5_VaccUptake <- factor(test_set$CAM5_VaccUptake, levels = levels(train_set$CAM5_VaccUptake))
confusion <- confusionMatrix(predictions, test_set$CAM5_VaccUptake)

print(confusion)

print("=============================================")
print("finished svm all features")



print("=============================================")
print("svm my features")

all_feature_data_without_character$CAM5_VaccUptake <- as.factor(all_feature_data_without_character$CAM5_VaccUptake)
levels(all_feature_data_without_character$CAM5_VaccUptake) <- make.names(levels(all_feature_data_without_character$CAM5_VaccUptake))


set.seed(123)
splitIndex <- createDataPartition(all_feature_data_without_character$CAM5_VaccUptake, p = 0.8, list = FALSE)
train_set <- all_feature_data_without_character[splitIndex, ]
test_set <- all_feature_data_without_character[-splitIndex, ]


control <- trainControl(method = "cv", number = 10, summaryFunction = multiClassSummary, classProbs = TRUE)


svm_model <- train(CAM5_VaccUptake ~ income + ppeducat + CV8a + CV6a_Rec + CV14_1 + CV14_2 + CV14_3 + CV14_4,
                   data = train_set,
                   method = "svmRadial",
                   trControl = control)


predictions <- predict(svm_model, newdata = test_set)

test_set$CAM5_VaccUptake <- factor(test_set$CAM5_VaccUptake, levels = levels(train_set$CAM5_VaccUptake))
confusion <- confusionMatrix(predictions, test_set$CAM5_VaccUptake)

# print confusion matrix
print(confusion)

print("=============================================")
print("finished svm my features")




print("=============================================")
print('kmeans_model')


set.seed(1) 
# return the data without character
all_feature_data <- subset(data, (CV14_1 != -99 & CV14_1 != -100)& (CV14_2 != -99 & CV14_2 != -100)& (CV14_3 != -99 & CV14_3 != -100)
                        & (CV14_4 != -99 & CV14_4 != -100)&(CAM5_VaccUptake != -99)&(CV8a !=99)&(CV6a_Rec !=99),  )

all_feature_data_without_character <- all_feature_data[sapply(all_feature_data, function(x) !is.character(x))]


splitIndex <- createDataPartition(all_feature_data_without_character$CAM5_VaccUptake, p = 0.8, list = FALSE)
train_set <- all_feature_data_without_character[splitIndex, ]
test_set <- all_feature_data_without_character[-splitIndex, ]


kmeans <- kmeans(scale(all_feature_data_without_character[, -ncol(all_feature_data_without_character)]), centers = 3, nstart = 25)
fviz_cluster(kmeans, data = scale(all_feature_data_without_character[, -ncol(test_set)])) + 
  ggtitle("K-Means Clustering Results on Test Set")
ggsave("KMeans_Clustering_Test.png")


print(kmeans)

fviz_nbclust(all_feature_data_without_character, kmeans, method = "wss")
ggsave("kmeans_fviz_nbclust.jpg")


gap_stat <- clusGap(all_feature_data_without_character, FUN = kmeans, nstart = 25, K.max = 10, B = 50)
fviz_gap_stat(gap_stat)
ggsave("kmeans_gap_stat.jpg")




print("=============================================")
print('finished kmeans_model')

#create the heatmap model
jpeg("heatmap.jpg")
data <- as.matrix(sapply(all_feature_data_without_character, as.numeric))
heatmap(data, scale = "column", Rowv = NA, Colv = NA, col = cm.colors(256),margins = c(5, 10), main = "heatmap of all features")
dev.off()

