data(iqitems)
#
data(ability)
ability.irt <- irt.fa(ability)
ability.scores <- score.irt(ability.irt,ability)

data(attitude)
cor(attitude)
# Compute eigenvalues and eigenvectors of the correlation matrix.
pfa.eigen<-eigen(cor(attitude))
pfa.eigen$values
    # set a value for the number of factors (for clarity)
    factors<-2
    # Extract and transform two components.
    pfa.eigen$vectors [ , 1:factors ]  %*% 
+ diag ( sqrt (pfa.eigen$values [ 1:factors ] ),factors,factors )
