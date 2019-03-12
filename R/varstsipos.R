varstsipos <-
function(y,stratum,nh,poststratum) {
   H1<- length(table(poststratum))
   X1<- t(1*outer(poststratum,names(table(poststratum)),"=="))
   B0<- matrix(by(y,poststratum,mean),H1,1)
   E2<- as.vector(y-(t(X1)%*%B0))
   varstsi(E2,stratum,nh)        
}
