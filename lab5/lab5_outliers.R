#Cook's Distance' example using mtcars
mtcars
head(mtcars)
str(mtcars)
model1<-lm(mpg~cyl + wt,data=mtcars)
model1
help("cooks.distance")
plot(model1, pch = 18, col= 'red', which=c(4))
# we can use the cooks.distance() function to identify the Cook's distance to
# each observation
cooks.distance (model1)
CooksDistance <- cooks.distance(model1)

# we can use the cooks.distance() function to identify the Cook's distance to # each observation
cooks.distance (model1)
CooksDistance <- cooks.distance (model1)
# Now we will round off the values to 5 desimal points so that it is easy to read
# we can use the round() function to round off values in R.
round(CooksDistance, 5)
sort(round(CooksDistance, 5))


# Outlier Detection using "Cooks Distance"
# Multivariate Regression using Cook's Distance
# Cook's Distance is an estimate of the influence of a data point.
# Cook's Distance is a summary of how much a regression model changes when the ith observation is removed from the data. 
library(ISLR)
library(dplyr)
# Let's look at the baseball hitters dataset in ISLR package.
head (Hitters)
dim(Hitters)
is.na(Hitters) # check for the missing values.
# Now we will remove the NA (missing values) using the na.ommit() function
HittersData <- na.omit(Hitters)
dim(HittersData) # checking the dimensions after removing the NAs.
glimpse(HittersData)
head(HittersData)
# Now we will implement a multivariate regression model using all the features in the dataset to # predict the salary of the Baseball player
SalaryPredictModel1 <- lm(Salary~., data= HittersData)
summary(SalaryPredictModel1)
# Multiple R-squared: 0.5461, Adjusted R-squared: 0.5106


# Cook's Distance.
cooksD <- cooks.distance (SalaryPredictModel1)
influential <- cooksD[(cooksD> (3* mean(cooksD, na.rm = TRUE)))]
influential
# We see that 18 players have a Cook's Distance greater than 3x the mean.
# Let's exclude these 18 players and rerun the model to see if we have a better fit in our regression model. 
names_of_influential <- names (influential) # checking the names of the influential/outlier players names_of_influential
outliers <- HittersData[names_of_influential,]
Hitters_Without_Outliers <- HittersData %>% anti_join(outliers)
# Model 2: without the outliers 
SalaryPredictModel2 <- lm(Salary~.,data=Hitters_Without_Outliers)
summary(SalaryPredictModel2)

# Multiple R-squared: 0.6721, Adjusted R-squared: 0.6445
# We have improved from an Adjusted R-Squared of 0.5106 to 0.6445 with the removal of only 18 observations


