install.packages("Hmisc")
library(Hmisc)
AthleticsData <- spss.get("AthleticsData.sav")
attach(AthleticsData)
#
names(AthleticsData)

cor(AthleticsData)
prcomp(AthleticsData)

fit.2 <- factanal(AthleticsData,factors=2,rotation="varimax")
print(fit.2)

fit.3 <- factanal(AthleticsData,factors=3,rotation="varimax")
print(fit.3)
print(fit.3, digits = 2, cutoff = .2, sort = TRUE)

install.packages("GPArotation")
library(GPArotation)

fit <- principal(AthleticsData, nfactors=3, rotate=”varimax”)
fit # print results


# do not go past here unless you can find fa.promax.R



fit.3.promax <- update(fit.3,rotation="promax") 
colnames(fit.3.promax$loadings)<-c("Endurance","Strength","Hand-Eye") 
print(loadings(fit.3.promax), digits = 2, cutoff = .2, sort = TRUE)
AssignFactorNames <- function(fit.object,names)
{
colnames(fit.object$promax.loadings)<-names
colnames(fit.object$varimax.loadings)<-names
rownames(fit.object$corr.factors)<-names
colnames(fit.object$corr.factors)<-names
}
fit.3.Enzmann <- fa.promax(AthleticsData,factors=3, digits=2, sort=TRUE) AssignFactorNames(fit.3.Enzmann,factor.names)
fit.3.Enzmann


