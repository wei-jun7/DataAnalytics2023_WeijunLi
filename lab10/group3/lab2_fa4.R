data(epi)
epi.keys <- make.keys(epi,list(E = c(1, 3, -5, 8, 10, 13, -15, 17, -20, 22, 25, 27,
                -29, -32, -34, -37, 39, -41, 44, 46, 49, -51, 53, 56),
   N=c(2, 4, 7, 9, 11, 14, 16, 19, 21, 23, 26, 28, 31, 33, 35, 38, 40,
     43, 45, 47, 50, 52, 55, 57),
   L = c(6, -12, -18, 24, -30, 36, -42, -48, -54),
   I =c(1, 3, -5, 8, 10, 13, 22, 39, -41), 
   S = c(-11, -15, 17, -20, 25, 27, -29, -32, -37, 44, 46, -51, 53)))
scores <- scoreItems(epi.keys,epi)
  N <- epi[abs(epi.keys[,"N"]) >0]
  E <- epi[abs(epi.keys[,"E"]) >0]
  fa.lookup(epi.keys[,1:3],epi.dictionary) #show the items and keying information
