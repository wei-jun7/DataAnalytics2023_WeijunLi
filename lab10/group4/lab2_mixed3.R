library(lme4)
lmm.1 <- lmer(extro ~ open + social + class + (1|school/class), data = lmm.data)
summary(lmm.1)

lmm.2 <- lmer(extro ~ open + agree + social + class + (1|school/class), data = lmm.data)
summary(lmm.2)

#print extracted fixed effect coeffs... (save them?)
fixef(lmm.2)

# To extract the estimates of the random effects parameters.
ranef(lmm.2)

coef(lmm.2)$'class:school’ # specific coeffs....

#then....

# To extract the predicted values (based on the fitted model).

yhat <- fitted(lmm.2)
summary(yhat)

# To extract the residuals (errors); and summarize, as well as plot them.

residuals <- resid(lmm.2)
summary(residuals)
hist(residuals)
