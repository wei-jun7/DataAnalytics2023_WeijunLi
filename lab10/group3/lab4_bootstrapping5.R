library(fpc)
  options(digits=3)
  set.seed(20000)
  face <- rFace(50,dMoNo=2,dNoEy=0,p=2)
  cf1 <- clusterboot(face,B=3,bootmethod=
          c("boot","noise","jitter"),clustermethod=kmeansCBI,
          krange=5,seed=15555)

  print(cf1)
  plot(cf1)


  cf2 <- clusterboot(dist(face),B=3,bootmethod=
          "subset",clustermethod=disthclustCBI,
          k=5, cut="number", method="average", showplots=TRUE, seed=15555)
  print(cf2)
