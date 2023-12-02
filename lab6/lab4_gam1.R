library(mboost)
library(TH.data)
?mboost_fit
data(bodyfat)
head(bodyfat)
tail(bodyfat)
summary(bodyfat)
boxplot(bodyfat)
#
lm1 <- lm(DEXfat ~ hipcirc + kneebreadth + anthro3a, data = bodyfat)
coef(lm1)
## Estimate same model by glmboost
glm1 <- glmboost(DEXfat ~ hipcirc + kneebreadth + anthro3a, data = bodyfat)
coef(glm1, off2int=TRUE) ## off2int adds the offset to the intercept
# We consider all available variables as potential predictors. 
glm2 <- glmboost(DEXfat ~ ., data = bodyfat)
# or one could essentially call:
preds <- names(bodyfat[, names(bodyfat) != "DEXfat"]) ## names of predictors
fm <- as.formula(paste("DEXfat ~", paste(preds, collapse = "+"))) ## build formula
# take a look
fm

#
coef(glm2, which = "") ## with which = "" we select all.
plot(glm2, off2int = TRUE) ## default plot, offset added to intercept
## now change ylim to the range of the coefficients without intercept (zoom-in)
plot(glm2, ylim = range(coef(glm2, which = preds)))

# try these again with different parameters
## initial number of boosting iterations. Default: 100
## step length. Default: 0.1
boost_control(mstop = 200, nu = 0.05, trace = TRUE) ## print status information? Default: FALSE


# examine the learners

z <- factor(1:3)
extract(bols(z))

gam1 <- gamboost(DEXfat ~ bbs(hipcirc) + bbs(kneebreadth) + bbs(anthro3a),data = bodyfat)
#Using plot() on a gamboost object delivers automatically the partial eﬀects of the diﬀerent base-learners:
par(mfrow = c(1,3)) ## 3 plots in one device
plot(gam1) ## get the partial effects
# and prevent overfitting

gam2 <- gamboost(DEXfat ~ ., baselearner = "bbs", data = bodyfat,control = boost_control(trace = TRUE))
set.seed(123) ## set seed to make results reproducible
cvm <- cvrisk(gam2) ## default method is 25-fold bootstrap cross-validation
## if package ’multicore’ is not available this will trigger a warning
# look at output
cvm
# set plot window back
par(mfrow = c(1,1))
plot(cvm)

mstop(cvm) ## extract the optimal mstop
gam2[ mstop(cvm) ] ## set the model automatically to the optimal mstop
# We have now reduced the model of the object gam2 to the one with only 30 boosting iterations, without further assignment. 
# However, as pointed out above, the other iterations are not lost. To check which variables are now included in the additive predictor we again use the function coef():
names(coef(gam2)) ## displays the selected base-learners at iteration 30
## To see that nothing got lost we now increase mstop to 1000:
gam2[1000, return = FALSE] # return = FALSE just supresses "print(gam2)"

names(coef(gam2)) ## displays the selected base-learners, now at iteration 1000

glm3 <- glmboost(DEXfat ~ hipcirc + kneebreadth + anthro3a, data = bodyfat,family = QuantReg(tau = 0.5), control = boost_control(mstop = 500))
coef(glm3, off2int = TRUE)

