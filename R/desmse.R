desmse <-
function(y,x,n,H,d2,d4) {
   estrato1<- optiallo(n,x^d2,H=H)
   estrato2<- optiallo(n,x^d4,H=H)
   varianza1<- varpipsreg(y,x^d4,n,x^d2)
   varianza2<- varstsireg(y,estrato2$stratum,estrato2$nh,x^d2)
   varianza3<- varstsi(y,estrato1$stratum,estrato1$nh)
   varianza4<- varpipspos(y,x^d4,n,estrato1$stratum)
   varianza5<- varstsipos(y,estrato2$stratum,estrato2$nh,estrato1$stratum)
   c(varianza1,varianza2,varianza3,varianza4,varianza5)
}
