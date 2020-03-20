expmse <-
function (b, d, x, n, H, Rxy,estrato1=NULL,estrato2=NULL,st=1:5,short=FALSE) {
   variance1<- variance2<- variance3<- variance4<- variance5<- NA
   F0<- (cov(x,x^b[1])^2)*((1/(Rxy^2))-(1/(cor(x,x^b[1])^2)))/(mean(x^(2*b[2]))*var(x))
   F0<- max(F0,0)

   if (1%in%st|4%in%st) {pik<- pinc(n,x^d[2])}
   if (is.null(estrato2)&(2%in%st|5%in%st)) {estrato2 <- optiallo(n,x^d[2],H=H)}
   if (is.null(estrato1)&(3%in%st|4%in%st|5%in%st)) {estrato1 <- optiallo(n,x^d[1],H=H)}

   if (1%in%st|4%in%st) {term1<- sum((x^(2*b[2]))/pik)}
   if (2%in%st|5%in%st) {term2<- sum(as.vector(table(estrato2$stratum)*by(x^(2*b[2]),estrato2$stratum,sum)/by(estrato2$nh,estrato2$stratum,mean)))}

   if (1%in%st|2%in%st) {vk1<- ((x^b[1])-mean(x^b[1])) - ((x^d[1])-mean(x^d[1]))*cov(x^b[1],x^d[1])/var(x^d[1])}
   if (4%in%st|5%in%st) {
      gbar<- as.vector(by(x^b[1],estrato1$stratum,mean))
      gbar<- gbar[estrato1$stratum]
      vk3<- x^b[1]-gbar
   }

   constant<- sum(x^(2*b[2]))

   if (1%in%st) {variance1<- varpips(vk1,pik,n)+F0*(term1-constant)}
   if (2%in%st) {variance2<- varstsi(vk1,estrato2$stratum,estrato2$nh)+F0*(term2-constant)}
   if (3%in%st) {
      vk2<- x^b[1]
      term1<- sum(as.vector(table(estrato1$stratum)*by(x^(2*b[2]),estrato1$stratum,sum)/by(estrato1$nh,estrato1$stratum,mean)))
      variance3<- varstsi(vk2,estrato1$stratum,estrato1$nh)+F0*(term1-constant)
   }
   if (4%in%st) {variance4<- varpips(vk3,pik,n)+F0*(term1-constant)}
   if (5%in%st) {variance5<- varstsi(vk3,estrato2$stratum,estrato2$nh)+F0*(term2-constant)}
   varianzas <- c(variance1, variance2, variance3, variance4, variance5)
   if (short) {varianzas<- varianzas[is.na(varianzas)==FALSE]}
   varianzas
}
