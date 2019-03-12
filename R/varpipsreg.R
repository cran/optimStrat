varpipsreg <-
function(y,x_des,n,x_est) {
   N<- length(y)
   tx<- sum(x_est)
   tx2<- sum(x_est^2)
   ty<- sum(y)
   txy<- sum(x_est*y)
   B2<- (N*txy-tx*ty)/(N*tx2-tx*tx)
   B1<- (ty-B2*tx)/N
   E1<- y-B1-B2*x_est
   varpips(E1,x_des,n)
}
