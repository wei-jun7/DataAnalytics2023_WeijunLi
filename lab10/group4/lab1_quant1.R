library(quantreg)
data(stackloss)
rq(stack.loss ~ stack.x,.5)  #median (l1) regression  fit for the stackloss data. 
rq(stack.loss ~ stack.x,.25)  #the 1st quartile, 
        #note that 8 of the 21 points lie exactly on this plane in 4-space! 
rq(stack.loss ~ stack.x, tau=-1)   #this returns the full rq process
rq(rnorm(50) ~ 1, ci=FALSE)    #ordinary sample median --no rank inversion ci
rq(rnorm(50) ~ 1, weights=runif(50),ci=FALSE)  #weighted sample median 
#plot of engel data and some rq lines see KB(1982) for references to data
data(engel)
attach(engel)
plot(x,y,xlab="Household Income",ylab="Food Expenditure",type = "n", cex=.5)
points(x,y,cex=.5,col="blue")
taus <- c(.05,.1,.25,.75,.9,.95)
xx <- seq(min(x),max(x),100)
f <- coef(rq((y)~(x),tau=taus))
yy <- cbind(1,xx)%*%f
for(i in 1:length(taus)){
        lines(xx,yy[,i],col = "gray")
        }
abline(lm(y~x),col="red",lty = 2)
abline(rq(y~x),col="blue")
legend(3000,500,c("mean (LSE) fit", "median (LAE) fit"),col = c("red","blue"),lty = c(2,1))
#Example of plotting of coefficients and their confidence bands
plot(summary(rq(y~x,tau = 1:49/50,data=engel)))
#Example to illustrate inequality constrained fitting
n <- 100
p <- 5
X <- matrix(rnorm(n*p),n,p)
y <- .95*apply(X,1,sum)+rnorm(n)
#constrain slope coefficients to lie between zero and one
R <- cbind(0,rbind(diag(p),-diag(p)))
r <- c(rep(0,p),-rep(1,p))
rq(y~X,R=R,r=r,method="fnc")

# and
# http://archive.ics.uci.edu/ml/datasets/Student+Performance
# http://archive.ics.uci.edu/ml/datasets/NoisyOffice
# http://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset
