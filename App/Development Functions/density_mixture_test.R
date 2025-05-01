
library(fitdistrplus)
library(distr)

##################################################
#Optimisation function - Normal
##################################################

prior_optim_norm <- function(q_50, q_75){
  Match_pctiles <- c(0.5,0.75)
  ofn_pctiles <- function(x,Exp_pctiles){
    Fit_pctiles <- qnorm(Match_pctiles,x[1],x[2])
    y = sum(abs(Fit_pctiles - Exp_pctiles)^2)
    return(y)
  }
  Chosenqmfit <- c(q_50, q_75)
  Chosenosol <- optim(par=c(1,1), ofn_pctiles, Exp_pctiles = Chosenqmfit, control=list(maxit = 1000))
  return(Chosenosol$par)
}

#Normal density plot
plot_dist_norm <- function(parm, xmin, xmax){
  p = seq(xmin, xmax, by=0.01)
  d = dnorm(p,parm[1],parm[2])	
  return(data.frame(p, d))
}

##################################################
#Optimisation function - Skew Normal
##################################################

prior_optim_sknorm <- function(q_25, q_50, q_75){
  Match_pctiles <- c(0.25,0.5,0.75)
  ofn_pctiles <- function(x,Exp_pctiles){
    Fit_pctiles <- qsn(Match_pctiles,xi=x[1],omega=x[2],alpha=x[3])
    y = sum(abs(Fit_pctiles - Exp_pctiles)^2)
    return(y)
  }
  Chosenqmfit <- c(q_25, q_50, q_75)
  Chosenosol <- optim(par=c(0.1,1,1), ofn_pctiles, Exp_pctiles = Chosenqmfit, control=list(maxit = 1000))
  return(Chosenosol$par)
}

#Skew-Normal density plot
plot_dist_sknorm <- function(parm, xmin, xmax){
  p = seq(xmin, xmax, by=0.1)
  d = dsn(p,xi=parm[1],omega=parm[2],alpha=parm[3])	
  return(data.frame(p, d))
}

####################################

#Test data
test_dat1 <- c(rep(5,0),rep(15,1), rep(25,1), rep(35,4), rep(45,5),rep(55,7),rep(65,2),rep(75,0),rep(85,0),rep(95,0))
test_dat2 <- c(rep(5,0),rep(15,0), rep(25,0), rep(35,1), rep(45,4),rep(55,8),rep(65,3),rep(75,2),rep(85,1),rep(95,1))
test_dat3 <- c(rep(-55,1),rep(-45,7), rep(-35,2), rep(-25,2), rep(-15,2),rep(-5,1),rep(5,1),rep(15,0),rep(25,0),rep(35,0))

parm1 <- prior_optim_norm(quantile(test_dat1,0.5), quantile(test_dat1,0.75))
parm2 <- prior_optim_norm(quantile(test_dat2,0.5), quantile(test_dat2,0.75))
parm3 <- prior_optim_norm(quantile(test_dat3,0.5), quantile(test_dat3,0.75))

myMix <- UnivarMixingDistribution(Norm(mean=parm1[1], sd=parm1[2]), 
                                  Norm(mean=parm2[1], sd=parm2[2]),
                                  Norm(mean=parm3[1], sd=parm3[2]),
                                  mixCoeff=c(1/3, 1/3, 1/3))


rmyMix <- r(myMix)
x <- rmyMix(1e6)
hist(x[x>-100 & x<100], breaks=100, col="grey", main="")
plot(myMix, to.draw.arg="d")
