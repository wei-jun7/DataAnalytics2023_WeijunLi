library(Rearrangement) ## not in CRAN - find the tar.gz file and install it separately

data(GrowthChart)
attach(GrowthChart)
 
# first do Simultaneous Confidence Interval Estimation using Bootstrap
nage <- 2 * pi * (age - min(age)) / (max(age) - min(age))
nages <- unique(sort(nage))
formula <- height~I(sin(nage))+I(cos(nage))+I(sin(2*nage))+I(cos(2*nage))+I(sin(3*nage))+I(cos(3*nage))+I(sin(4*nage))+I(cos(4*nage))
j <- simconboot(nage,height,lm,formula)
plot(j, border=NA, col='darkgray',xlab = 'Age (years)',ylab = 'Height (cms)',xaxt = "n")
axis(1, at = seq(-2*pi*min(age)/(max(age)-min(age)), 2*pi+1, by=5*2*pi/(max(age)-min(age))), label = seq(0, max(age)+1, by=5))
points(nage,height)
lines(nages, j$cef, lty=2, col='green')

#now do Local Linear Regression Methods for Conditional Mean Functions
ages <- unique(sort(age))
lplm.fit1 <- lplm(age,height,h=1,xx=ages)

# exercise - plot the fits, evaluate it.
 
detach(GrowthChart)

# and
# http://archive.ics.uci.edu/ml/datasets/Student+Performance
# http://archive.ics.uci.edu/ml/datasets/NoisyOffice
# http://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset
