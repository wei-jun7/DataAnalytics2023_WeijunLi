
# Normality Tests....
# Normal Distribution
# Read the documentation of the random distribution function
help("rnorm")
set.seed(10)
data1 <- rnorm(50)
set.seed(30)
data2<- rnorm(50)
#Shapiro-Wilk Normality Test
# Read the documentation of hapiro-Wilk Normality Test
help("shapiro.test")
# As the test returns a p-value less than 0.05, we reject the null hypothesis
# and conclude that the population data is not normally distributed.
shapiro.test(data1)
hist(datal, col='green')
# the histogram shows that the curve is mildly left skewed in nature
shapiro.test(data2)
# As the test returns a p-value greater than 0.05, we accept the null hypothesis
# and conclude that the population data is normally distributed.
hist(data2, col='steelblue') # the histogram shows that the curve is normally distributed in nature



# we set the seed to make the example reproducible
set.seed(0)
#create dataset of 100 random values generated from a normal distribution
data<- rnorm(100)
#perform Shapiro-Wilk test for normality
shapiro.test(data)
# The p-value of the test turns out to be 0.6303.
# Since this value is not less than 0.05, we can assume the sample data comes
# from a population that is normally distributed.
# This result shouldn't be surprising since we generated the sample data using the rnorm() function,
# which generates random values from a normal distribution with mean = 0 and standard deviation # Example 2: Shapiro-Wilk Test on Non-Normal Data= 1.
# The following code shows how to perform a Shapiro-Wilk test on a dataset with sample size n=100 in which #the values are randomly generated from a Poisson distribution:


