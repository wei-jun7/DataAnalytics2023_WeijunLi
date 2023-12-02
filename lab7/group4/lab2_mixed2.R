# generalized linear model without normal distribution assumption.

glm.1 <- glm(extro ~ open + social + class + school, data = lmm.data)
summary(glm.1)

glm.2 <- glm(extro ~ open + social + class:school, data = lmm.data)
#look at output (summary, etc.)

glm.3 <- glm(extro ~ open + agree + social + class:school, data = lmm.data)
#look at output (summary, etc.)

