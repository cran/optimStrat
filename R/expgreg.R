expgreg <-
function(x,b11,b12,b21,b22,d12,Rfy,n,design=NULL,stratum=NULL,x_des=NULL,inc.p=NULL,...) {
   n_poi<- n
   xd<- t(t(x)^d12)
   xb<- t(t(x)^b12)
   xb2<- t(t(x)^b22)
   A<- lm(xb~xd-1,...)$coefficients
   fbk<- as.vector(xb%*%b11)
   fdk<- as.vector((xd%*%A)%*%b11)
   gbk<- as.vector(xb2%*%b21)
   N<- length(fbk)
   y<- fbk-fdk
   sigmahat<- var(fbk)*((1/(Rfy^2))-1)/mean(gbk^2)
   if (design=="srs") {pik<- rep(n/N,times=N)}
   if (design=="stsi") {
      Nh<- as.vector(by(stratum,stratum,length))
      stratum2<- sort(unique(stratum))
      Nh<- Nh[match(stratum,stratum2)]
      pik<- n/Nh
      n_poi<- sum(as.vector(by(n,stratum,mean)))
   }
   if (design%in%c("poi","pips")) {pik<- pinc(n,x_des)}
   if (is.null(design)) {
      inc.p<- n*inc.p/sum(diag(inc.p))
      pik<- diag(inc.p)
   }
   vargreg(y~0,design=design,n=n,stratum=stratum,x_des=x_des,inc.p=inc.p)+sigmahat*vargreg(gbk~0,design="poi",n=n_poi,x_des=pik)   
}
