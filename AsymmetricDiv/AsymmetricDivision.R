
####Data####
N_WT=209
k_WT=104
N_mut=342
k_mut=191

theta = seq(0.005, 0.995, length = 500)
#####Calculate posterior distributions for each strain####
wt<-dbeta(theta,1+k_WT,1+N_WT-k_WT)
mut<-dbeta(theta,1+k_mut,1+N_mut-k_mut)

#####Plot distributions####
m = max(c(mut, wt))
plot(theta, wt, type = "l", ylab = "P(p|k,N)", lty = 1, lwd = 2,
     ylim = c(0, m), col = 'purple',xlab = "p")
lines(theta, mut, lty = 1, lwd = 2, col = "blue")
legend(x=.7,y=m,c("WT", expression(italic(" mut1")*Delta)), lty = c(1, 1),
       lwd = c(3, 3), col = c("purple", "blue"),cex=.9)

#####Probability of p>0.5####
#Mutant1
1-pbeta(.5,1+k_mut,1+N_mut-k_mut)
#WT
1-pbeta(.5,1+k_WT,1+N_WT-k_WT)

#Binom test
binom.test(k_WT,N_WT,.5,"greater")
binom.test(k_mut,N_mut,.5,"greater")

