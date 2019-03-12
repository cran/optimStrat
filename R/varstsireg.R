varstsireg <-
function(y,stratum,nh,x) {
   N<- length(x)
   tx<- sum(x)
   tx2<- sum(x^2)
   ty<- sum(y)
   txy<- sum(x*y)
   B2<- (N*txy-tx*ty)/(N*tx2-tx*tx)
   B1<- (ty-B2*tx)/N
   E1<- y-B1-B2*x
   varstsi(E1,stratum,nh)
}
