data(data_Jointlcmm)
# Latent process mixed model for two curvilinear outcomes. Link functions are 
# aproximated by I-splines, the first one has 3 nodes (i.e. 1 internal node 8),
# the second one has 4 nodes (i.e. 2 internal nodes 12,25)

m1 <- multlcmm(Ydep1+Ydep2~1+Time*X2+contrast(X2),random=~1+Time,
subject="ID",randomY=TRUE,link=c("4-manual-splines","3-manual-splines"),
intnodes=c(8,12,25),data=data_Jointlcmm)

# to reduce the computation time, the same model is estimated using 
# a vector of initial values
m1 <- multlcmm(Ydep1+Ydep2~1+Time*X2+contrast(X2),random=~1+Time,
subject="ID",randomY=TRUE,link=c("4-manual-splines","3-manual-splines"),
intnodes=c(8,12,25),data=data_Jointlcmm, 
B=c(-1.071, -0.192,  0.106, -0.005, -0.193,  1.012,  0.870,  0.881,
  0.000,  0.000, -7.520,  1.401,  1.607 , 1.908,  1.431,  1.082,
 -7.528,  1.135 , 1.454 , 2.328, 1.052))


# output of the model
summary(m1)
# estimated link functions
plot(m1,which="linkfunction")
# variation percentages explained by linear mixed regression
VarExpl(m1,data.frame(Time=0))

#### Heterogeneous latent process mixed model with linear link functions 
#### and 2 latent classes of trajectory 
m2 <- multlcmm(Ydep1+Ydep2~1+Time*X2,random=~1+Time,subject="ID",
link="linear",ng=2,mixture=~1+Time,classmb=~1+X1,data=data_Jointlcmm,
B=c( 18,-20.77,1.16,-1.41,-1.39,-0.32,0.16,-0.26,1.69,1.12,1.1,10.8,
1.24,24.88,1.89))
# summary of the estimation
summary(m2)
# posterior classification
postprob(m2)
# longitudinal predictions in the outcomes scales for a given profile of covariates 
newdata <- data.frame(Time=seq(0,5,length=100),X1=rep(0,100),X2=rep(0,100),X3=rep(0,100))
predGH <- predictY(m2,newdata,var.time="Time",methInteg=0,nsim=20) 
head(predGH)

