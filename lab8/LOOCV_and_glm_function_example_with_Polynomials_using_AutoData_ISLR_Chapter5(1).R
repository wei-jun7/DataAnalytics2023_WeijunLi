glm.fit <- glm(mpg~horsepower, data=Auto) # we have not used the "family" argument here.
coef(glm.fit)
# and you can see this is similar to using the lm(), and the same results.
lm.fit <- lm(mpg~horsepower, data = Auto)
coef(lm.fit)
# We can perform linear regression using the glm() function rather than the lm() fuction
# because the former can be used together with cv.glm() function. 
# cv.glm() function is part of the boot library. Make sure to install the boot library first.
library(boot)
glm.fit <-glm(mpg ~ horsepower, data = Auto)
cv.err <- cv.glm(Auto, glm.fit)
# The cv.glm() function produces a list with several components. 
# The two numbers in the delta vector contain the corss-validation results. 
cv.err$delta
# In this case, two numbers are identical (upto two decimal places) and correspond to the LOOCV.
# Out cross-validation estimate for the test error is apporximately 24.23
# We can repeat this procedure for increasingly complex polynomial fits. 
# To aumtomate this process, we use the for() loop function to initiate a for-loop,
# which iteratively fits polynomial regression for polymomials of oder i=1 to i=5,
# and computes the associated cross-validation error, and stores it in "i"th element of,
# the vector cv.error.
# We begin by initializing the vector. 
# This might take couple of miniutes to run on your laptop based on it's computing power! :) :)
cv.error = rep(0,5)
for(i in 1:5){
  glm.fit <- glm(mpg~poly(horsepower,i), data = Auto)
  cv.error[i] = cv.glm(Auto, glm.fit)$delta[1]
}
cv.error
# We can see there is a drop in estimated test MSE between the linear and quadratic fits, 
# but no clear improvement for using the higher-order polynomials.