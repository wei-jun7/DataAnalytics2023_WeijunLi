# In this lab, we perform PCA on the USArrests data set, which is part of thebase R package.
#The rows of the data set contain the 50 states, in alphabetical order.
# We will use the USAArrest data that available on RStudio
data("USArrests")
help("USArrests") # Read thee documentation of USArrest data on RStudio.
states=row.names(USArrests)
states
# The columns of the data set contain the four variables.
names(USArrests )
# We first briefly examine the data. We notice that the variables have vastlydifferent means.
# Note that the apply() function allows us to apply a function—in this case,the mean() function
# to each row or column of the data set.
# The second input here denotes whether we wish to compute the mean ofthe rows, 1, or the columns, 2.
# We see that there are on average three times as many rapes as murders,
#and more than eight times as many assaults as rapes.
apply(USArrests , 2, mean)
# We can also examine the variances of the four variables using the apply()function.
apply(USArrests , 2, var)

# We now perform principal components analysis using the prcomp() function, which is one of several functions in R thatperform PCA.
# By default, the prcomp() function centers the variables to have mean zero. By using the option scale=TRUE,
# we scale the variables to have standard deviation one.
# The output from prcomp() contains a number of useful quantities.
pr.out=prcomp(USArrests, scale=TRUE)
names(pr.out)
# The center and scale components correspond to the means and standard deviations of the
# variables that were used for scaling prior to implementing PCA.
pr.out$center
pr.out$scale
# The rotation matrix provides the principal component loadings; each column of pr.out$rotation contains
# the corresponding principal component loading vector
# We see that
pr.out$rotation
dim(pr.out$x)
biplot(pr.out, scale=0)
pr.var = pr.out$sdev^2
pr.var
pve = pr.var/sum(pr.var)
pve
