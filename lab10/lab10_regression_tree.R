library(MASS)
library(tree)
set.seed(1)
head(Boston)
train = sample(1:nrow(Boston), nrow(Boston)/2)
tree.boston = tree(medv ~., Boston, subset = train)
summary(tree.boston)
# Note that the output summary() indicates that only three of the variables have been
# used to constructing the tree. In the context of a regression tree,
# the deviance is simply the sum of squared errors for the tree# Regression Tree
tree(formula = medv ~. , data = Boston, subset = train)
# We now plot the tree
plot(tree.boston)
text(tree.boston, pretty = 0)
# The variable "lstat" measure the percentage of the individuals with lower socioeconomics status.
# The tree indicates that the lower values of lstat corresponds to more expensive house.
# Now we use the cv.tree() function to see whether pruning the tree will
# improve performance.
cv.boston=cv.tree(tree.boston)
plot(cv.boston$size ,cv.boston$dev ,typ ='b')

prune.boston=prune.tree(tree.boston ,best=5)
plot(prune.boston)
text(prune.boston ,pretty=0)



# In keeping with the cross-validation results,
# we use the unpruned tree to make predictions on the test set.
yhat=predict(tree.boston ,newdata=Boston[-train ,])
boston.test=Boston[-train ,"medv"]
plot(yhat,boston.test)
# adding the abline()
abline(0,1)
mean((yhat-boston.test)^2)
# In other words, the test set MSE associated with the regression tree is 25.05.
# The square root of the MSE is therefore around 5.005,
# indicating that this model leads to test predictions that
# are within around $5, 005 of the true median home value for the suburb


# Bagging and Random Forest Example
library(randomForest)
set.seed(1)
bag.boston = randomForest(medv ~., data=Boston, subset = train, mtry=13, importance= TRUE)
bag.boston
# The argument mtry=13 indicates that all 13 predictors should be considered
# for each split of the tree—in other words, that bagging should be done.
# How well does this bagged model perform on the test set?
yhat.bag = predict(bag.boston ,newdata=Boston[-train ,])
plot(yhat.bag, boston.test)
# adding the abline()
abline(0,1)
mean((yhat.bag-boston.test)^2)



# The test set MSE associated with the bagged regression tree is 13.16,
#almost half that obtained using an optimally-pruned single tree.
#We could change the number of trees grown by randomForest() using the ntree
argument:
  bad.boston =
  bag.boston=randomForest(medv~.,data=Boston,subset=train, mtry=13,ntree=25)
yhat.bag = predict(bag.boston ,newdata=Boston[-train ,])
mean((yhat.bag-boston.test)^2)



set.seed(1)
rf.boston=randomForest(medv~.,data=Boston,subset=train,
                       mtry=6,importance =TRUE)
yhat.rf = predict(rf.boston ,newdata=Boston[-train ,])
mean((yhat.rf-boston.test)^2)
# The test set MSE is 11.31;
# this indicates that random forests yielded an improvement over bagging in this case.
# Using the importance() function, we can view the importance of each variable.


importance (rf.boston)


varImpPlot (rf.boston)

