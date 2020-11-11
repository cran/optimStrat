desvar <-
function(y,x,n,H,d2,d4) {
   x2<- x^d2
   x3<- x^d4
   st2<- optiallo(n,x2,H=H)
   st3<- optiallo(n,x3,H=H)
   x4<- as.factor(st2$stratum)
   varianza1<- vargreg("y~0",design="stsi",n=st2$nh,stratum=st2$stratum)
   varianza2<- vargreg("y~0",design="pips",n=n,x_des=x2)
   varianza3<- vargreg(y~x4,design="stsi",n=st3$nh,stratum=st3$stratum)
   varianza4<- vargreg(y~x4,design="pips",n=n,x_des=x3)
   varianza5<- vargreg(y~x2,design="stsi",n=st3$nh,stratum=st3$stratum)
   varianza6<- vargreg(y~x2,design="pips",n=n,x_des=x3)

   results<- c(varianza1,varianza2,varianza3,varianza4,varianza5,varianza6)
   names(results)<- c("stsi-ht","pips-ht","stsi-pos","pips-pos","stsi-reg","pips-reg")
   return(results)
}
