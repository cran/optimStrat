vargreg <-
function(formula,design=NULL,n,stratum=NULL,x_des=NULL,inc.p=NULL,...) {
   E<- lm(formula,...)
   E<- E$residuals
   if (identical(design,"srs")) {
      if (length(n)>1) {stop("The sample size should be a scalar.")}
      N<- length(E)
      varianza<- ((N^2)/n)*(1-n/N)*var(E)
   }
   if (identical(design,"poi")) {
      if (length(n)>1) {stop("The sample size should be a scalar.")}
      pik<- pinc(n,x_des)
      varianza<- sum((1/pik-1)*(E^2))
   }
   if (identical(design,"stsi")) {
      n2<- as.vector(by(n,stratum,var))
      if (max(n2,na.rm=TRUE)>0) {stop("The sample size is not constant within strata.")}
      SyUh2  <- as.vector(by(E,stratum,var))
      Nh<- as.vector(by(E,stratum,length))
      nh<- as.vector(by(n,stratum,mean))
      varianza<- sum(((Nh^2)/nh)*(1-(nh/Nh))*SyUh2,na.rm=TRUE)
    }
   if (identical(design,"pips")) {
      if (length(n)>1) {stop("The sample size should be a scalar.")}
      pik<- pinc(n,x_des)
      N<- sum(pik<1)
      term1<- sum((E^2)*(1-pik)/pik); term2<- sum(E*(1-pik)); term3<- sum(pik*(1-pik))
      varianza<- N*(term1-((term2^2)/term3))/(N-1)
   }
   if (is.null(design)) {
      if (identical(inc.p,t(inc.p))==FALSE) {stop("The matrix of inclusion probabilities must be symmetric.")}
      if (sum(apply(inc.p,1,max)>diag(inc.p))>0|min(inc.p)<0) {stop("Invalid second order inclusion probabilities.")}
      inc.p<- n*inc.p/sum(diag(inc.p))
      inc.p2<- diag(inc.p)%o%diag(inc.p)
      E2<- E%o%E
      varianza<- sum((inc.p-inc.p2)*E2/inc.p2)
   }
   return(varianza)
}
