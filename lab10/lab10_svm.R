library(e1071)
set.seed (1)
# We now use the svm() function to fit the support vector classifier for a given value of the cost parameter.
# Here we demonstrate the use of this function on a two-dimensional example so that we can plot the resulting
# decision boundary.
# We begin by generating the observations, which belong to two classes.
x=matrix(rnorm(20*2), ncol=2)
y=c(rep(-1,10), rep(1,10))
x[y==1,]=x[y==1,] + 1
x
y
# We begin by checking whether the classes are linearly separable.
plot(x, col=(3-y))
# They are not. Next, we fit the support vector classifier.
# Note that in order for the svm() function to perform classification
# we must encode the response as a factor variable.
# We now create a data frame with the response coded as a factor.
dat <- data.frame(x = x,y = as.factor(y))
svmfit <- svm(y ~., data=dat, kernel="linear", cost=10,scale=FALSE)
# The argument scale=FALSE tells the svm() function not to scale each feature to
# have mean zero or standard deviation one;
# depending on the application, one might prefer to use scale=TRUE.
# We can now plot the support vector classifier obtained:
plot(svmfit , dat)
# Note that the two arguments to the plot.svm() function are the output of the call to svm(),
#as well as the data used in the call to svm().
# The region of feature space that will be assigned to the −1 class is shown in light blue,
# and the region that will be assigned to the +1 class is shown in purple.

# We can determine the identities of those support vectors by:
svmfit$index
# You can see 1,2,5,7,14,16 and 17
# We can obtain some basic information about the support vector classifier fit using the summary()command:
summary(svmfit)


svmfit <- svm(y ~., data=dat, kernel="linear", cost = 0.1, scale=FALSE)
plot(svmfit , dat)
svmfit$index




set.seed (1)
tune.out <- tune(svm, y ~.,data=dat,kernel="linear", ranges=list(cost=c(0.001, 0.01, 0.1, 1,5,10,100)))
# We can easily access the cross-validation errors for each of these models using the summary() command:
summary(tune.out)
# We see that cost=0.1 results in the lowest cross-validation error rate.
# The tune() function stores the best model obtained, which can be accessed as follows:
bestmod=tune.out$best.model
summary(bestmod)
# The predict() function can be used to predict the class label on a set of test observations,
# at any given value of the cost parameter. We begin by generating a test data set.
xtest=matrix(rnorm(20*2), ncol=2)
ytest=sample(c(-1,1), 20, rep=TRUE)
xtest[ytest==1,]=xtest[ytest==1,] + 1
testdat=data.frame(x=xtest, y=as.factor(ytest))
# Now we predict the class labels of these test observations.
# Here we use the best model obtained through cross-validation in order to make predictions.
ypred <-predict(bestmod ,testdat)
table(predict=ypred, truth=testdat$y)
#Thus, with this value of cost, 19 of the test observations are correctly classified.
# What if we had instead used cost= 0.01?
svmfit <- svm(y~., data=dat, kernel="linear", cost=.01, scale=FALSE)
ypred=predict(svmfit ,testdat)
table(predict=ypred, truth=testdat$y)
# In this case one additional observation is misclassified.
# Now consider a situation in which the two classes are linearly separable.
# Then we can find a separating hyperplane using the svm() function.
# We first further separate the two classes in our simulated data so that they are linearly separable:
x[y==1,]=x[y==1,]+0.5
plot(x, col=(y+5)/2, pch=19)



# Now the observations are just barely linearly separable.
# We fit the support vector classifier and plot the resulting hyperplane,
# using a very large value of cost so that no observations are misclassified.
dat=data.frame(x=x,y=as.factor(y))
svmfit <-svm(y~., data=dat, kernel="linear", cost=1e5)
summary(svmfit)
plot(svmfit,dat)
# No training errors were made and only three support vectors were used.
# However, we can see from the figure that the margin is
# very narrow (because the observations that are not support vectors, indicated as circles, are very
# close to the decision boundary). It seems likely that this model will perform poorly on test data.
# We now try a smaller value of cost:
svmfit <- svm(y~., data=dat, kernel="linear", cost=1)
summary(svmfit)
plot(svmfit ,dat)
# Using cost=1, we misclassify a training observation, but we also obtain a much wider margin and make
# use of seven support vectors.
# It seems likely that this model will perform better on test data than the model with cost=1e5.

