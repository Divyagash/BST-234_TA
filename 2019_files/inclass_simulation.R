f <- function(p) {
  bs = 0.001;
  bn = bs/3;
  s = 12;
  x = p^(bs-1)*(1-p)^(bn-1)*2.71^(s*(1-p));
  return (x);
}

get_maf <- function(nsnps, maffilter=NULL){
  last = 0.1
  uniqmet = vector('numeric', length=nsnps)
  for (j in 1:1000){
    cand <- runif(1,0,1) # you may try a different distribution here
    alpha <- f(cand)/f(last)
    if (runif(1) < min(alpha, 1)) last <- cand
  }
  i=1
  k=2
  if (is.null(maffilter)){
    uniqmet[i] <- last
    while(sum(uniqmet==0)!=0){
      if (i %% 100000==1) print(sum(uniqmet==0))
      cand <- runif(1,0,1) # you may try a different distribution here
      alpha <- f(cand)/f(last)
      if (runif(1) < min(alpha, 1)) last <- cand
      if (uniqmet[k-1] != last){
        uniqmet[k] <- last;
        k <- k+1
      }
      i <- i+1
    }
  }else{
    print(maffilter)
    if (last > maffilter){
      last <- maffilter
    }
    uniqmet[i] <- last
    while(sum(uniqmet==0) != 0){
      if (i %% 100000==1) print(sum(uniqmet==0))
      cand <- runif(1,0,1) # you may try a different distribution here
      alpha <- f(cand)/f(last)
      if (runif(1) < min(alpha, 1)) last <- cand
      if (uniqmet[k-1] != last & last <= maffilter){
        uniqmet[k] <- last;
        k <- k+1
      }
      i <- i+1
    }
  }
  return(uniqmet)
}
nbrloci <- 1000 
n <- 10000 #sample size
mafdist <- get_maf(nbrloci)
hist(mafdist)
mean(mafdist)

#generation of genotypes
x1 <- (runif(n,0,1) < mafdist[1]) + (runif(n,0,1) < mafdist[1])
sum(x1 > 0)/n

# can we speed this up

x1b <- rbinom(n, 2, mafdist[1])
sum(x1b > 0)/n

avenz <- rep(0, nbrloci)

for(i in 1:nbrloci)
  avenz[i] <- sum(rbinom(n, 2, mafdist[i]) > 0)
  sum(avenz)/(nbrloci*n)

  start_time <- Sys.time()
  sims<-100
  davenz<-rep(0,sims)
  for(j in 1:sims) {
    avenz <- rep(0, nbrloci)
  for(i in 1:nbrloci)
    #avenz[i]<-sum(rbinom(n,2,mafdist[i])>0)
    avenz[i] <- rbinom(1, n, 1-(1-mafdist[i])^2)
  
    davenz[j] <- sum(avenz)/(nbrloci*n)
  
}  
end_time <- Sys.time()
print(end_time - start_time)
hist(davenz)

#
#
#
#
#
avenz[i] <- rbinom(1, n, 1-(1-mafdist[i])^2)