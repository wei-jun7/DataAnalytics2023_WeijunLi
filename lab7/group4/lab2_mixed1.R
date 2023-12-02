lmm.data <-spss.get("lmm.dataRC.sav")
# was lmm.data <- read.table("http://www.unt.edu/rss/class/Jon/R_SC/Module9/lmm.data.txt", header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)
summary(lmm.data)

head(lmm.data)

nrow(lmm.data)

lm.1 <- lm(extro ~ open + social, data = lmm.data)
summary(lm.1)

lm.2 <- lm(extro ~ open + agree + social, data = lmm.data)
summary(lm.2)

#analysis of variance:
anova(lm.1, lm.2)

lm.3 <- lm(extro ~ open + social + class + school, data = lmm.data)
summary(lm.3)

lm.4 <- lm(extro ~ open + agree + social + class + school, data = lmm.data)
summary(lm.4)

anova(lm.3, lm.4)

# 'class:school’ - different situation than one
# with random effects (e.g., nested variables). 
lm.5 <- lm(extro ~ open + social + class:school, data = lmm.data)
summary(lm.5)

lm.6 <- lm(extro ~ open + agree + social + class:school, data = lmm.data)
summary(lm.6) 

anova(lm.5, lm.6)


