varstsi <-
function(y,stratum,nh) {
  nh2<- as.vector(by(nh,stratum,var))
  if (max(nh2,na.rm=TRUE)>0) {stop("The sample size is not constant within strata.")}
  SyUh2  <- as.vector(by(y,stratum,var))
  Nh<- as.vector(by(y,stratum,length))
  nh<- as.vector(by(nh,stratum,mean))
  sum(((Nh^2)/nh)*(1-(nh/Nh))*SyUh2,na.rm=TRUE)
}
