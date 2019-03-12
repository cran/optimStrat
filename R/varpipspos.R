varpipspos <-
function(y,x_des,n,poststratum) {
   H1<- length(table(poststratum))
   X1<- t(1*outer(poststratum,names(table(poststratum)),"=="))
   B0<- matrix(by(y,poststratum,mean),H1,1)
   E2<- as.vector(y-(t(X1)%*%B0))
   varpips(E2,x_des,n)        
}
