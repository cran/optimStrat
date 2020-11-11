expvar <-
function (b, d, x, n, H, Rxy,stratum1=NULL,stratum2=NULL,st=1:5,short=FALSE) {
   variance1<- variance2<- variance3<- variance4<- variance5<- NA
   F0<- (cov(x,x^b[1])^2)*((1/(Rxy^2))-(1/(cor(x,x^b[1])^2)))/(mean(x^(2*b[2]))*var(x))
   F0<- max(F0,0)

   if (1%in%st|4%in%st) {pik<- pinc(n,x^d[2])}
   if (is.null(stratum2)&(2%in%st|5%in%st)) {stratum2 <- optiallo(n,x^d[2],H=H)}
   if (is.null(stratum1)&(3%in%st|4%in%st|5%in%st)) {stratum1 <- optiallo(n,x^d[1],H=H)}

   if (1%in%st|4%in%st) {term1<- sum((x^(2*b[2]))/pik)}
   if (2%in%st|5%in%st) {term2<- sum(as.vector(table(stratum2$stratum)*by(x^(2*b[2]),stratum2$stratum,sum)/by(stratum2$nh,stratum2$stratum,mean)))}

   if (1%in%st|2%in%st) {vk1<- ((x^b[1])-mean(x^b[1])) - ((x^d[1])-mean(x^d[1]))*cov(x^b[1],x^d[1])/var(x^d[1])}
   if (4%in%st|5%in%st) {
      gbar<- as.vector(by(x^b[1],stratum1$stratum,mean))
      gbar<- gbar[stratum1$stratum]
      vk3<- x^b[1]-gbar
   }

   constant<- sum(x^(2*b[2]))

   if (1%in%st) {variance1<- vargreg(vk1~0,design="pips",n=n,x_des=pik)+F0*(term1-constant)}
   if (2%in%st) {variance2<- vargreg(vk1~0,design="stsi",n=stratum2$nh,stratum=stratum2$stratum)+F0*(term2-constant)}
   if (3%in%st) {
      vk2<- x^b[1]
      term1<- sum(as.vector(table(stratum1$stratum)*by(x^(2*b[2]),stratum1$stratum,sum)/by(stratum1$nh,stratum1$stratum,mean)))
      variance3<- vargreg(vk2~0,design="stsi",n=stratum1$nh,stratum=stratum1$stratum)+F0*(term1-constant)
   }
   if (4%in%st) {variance4<- vargreg(vk3~0,design="pips",n=n,x_des=pik)+F0*(term1-constant)}
   if (5%in%st) {variance5<- vargreg(vk3~0,design="stsi",n=stratum2$nh,stratum=stratum2$stratum)+F0*(term2-constant)}
   varianzas <- c(variance1, variance2, variance3, variance4, variance5)
   if (short) {varianzas<- varianzas[is.na(varianzas)==FALSE]}
   varianzas
}
