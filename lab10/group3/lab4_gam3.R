install.packages("GAMBoost")
# read - http://cran.r-project.org/web/packages/GAMBoost/GAMBoost.pdf
library(GAMBoost)
x <- matrix(runif(100*8,min=-1,max=1),100,8)
eta <- -0.5 + 2*x[,1] + 2*x[,3]^2
y <- rbinom(100,1,binomial()$linkinv(eta))
##  Fit the model with smooth components
gb1 <- GAMBoost(x,y,penalty=400,stepno=100,trace=TRUE,family=binomial())
##  10-fold cross-validation with prediction error as a criterion
gb1.crit <- cv.GAMBoost(x,y,penalty=400,maxstepno=100,trace=TRUE, family=binomial(), K=10,type="error",just.criterion=TRUE)
##  Compare AIC and estimated prediction error
which.min(gb1$AIC)
which.min(gb1.crit$criterion)
# do more examples
