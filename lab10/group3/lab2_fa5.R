set.seed(1.234)
N <- 200                             # number of observations
P <- 6                               # number of variables
Q <- 2                               # number of factors

# true P x Q loading matrix -> variable-factor correlations
Lambda <- matrix(c(0.7,-0.4, 0.8,0, -0.2,0.9, -0.3,0.4, 0.3,0.7, -0.8,0.1),
                 nrow=P, ncol=Q, byrow=TRUE)

library(mvtnorm)                      # for rmvnorm()
FF  <- rmvnorm(N, mean=c(5, 15), sigma=diag(Q))    # factor scores (uncorrelated factors)
E   <- rmvnorm(N, rep(0, P), diag(P)) # matrix with iid, mean 0, normal errors
X   <- FF %*% t(Lambda) + E           # matrix with variable values
Xdf <- data.frame(X)                  # data also as a data frame


library(psych) # for fa(), fa.poly(), factor.plot(), fa.diagram(), fa.parallel.poly, vss()
fa(X, nfactors=2, rotate="varimax")$loadings     # factor analysis continuous data

# dichotomize variables into a list of ordered factors
Xdi    <- lapply(Xdf, function(x) cut(x, breaks=c(-Inf, median(x), Inf), ordered=TRUE))
Xdidf  <- do.call("data.frame", Xdi) # combine list into a data frame
XdiNum <- data.matrix(Xdidf)         # dichotomized data as a numeric matrix

library(polycor)                     # for hetcor()
pc <- hetcor(Xdidf, ML=TRUE)         # polychoric corr matrix -> component correlations

#

faPC <- fa(r=pc$correlations, nfactors=2, n.obs=N, rotate="varimax")
faPC$loadings
#
faPCdirect <- fa.poly(XdiNum, nfactors=2, rotate="varimax")    # polychoric FA
faPCdirect$fa$loadings        # loadings are the same as above ...
#### NB: For factor scores, look at package ltm which has a factor.scores() function specifically for polytomous outcome data. An example is provided on this page -> "Factor Scores - Ability Estimates".

factor.plot(faPCdirect$fa, cut=0.5)
fa.diagram(faPCdirect)

fa.parallel.poly(XdiNum)      # parallel analysis for dichotomous data
vss(pc$correlations, n.obs=N, rotate="varimax")   # very simple structure
#
library(random.polychor.pa)    # for random.polychor.pa()
random.polychor.pa(data.matrix=XdiNum, nrep=5, q.eigen=0.99)
