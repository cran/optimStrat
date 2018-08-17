optiallo <-
function(n,x,y=x,stratum) {
  SyUh2  <- as.vector(by(y,stratum,var))
  SxUh   <- as.vector(by(x,stratum,sd))
  SxUh[is.na(SxUh)]  <- sum(SxUh,na.rm=TRUE)
  SyUh2[is.na(SyUh2)]<- 0
  if (min(SxUh)==0&max(SxUh)==0) {SxUh<- SxUh+1}
  Nh     <- as.vector(by(x,stratum,length))
  nh     <- n*Nh*SxUh/sum(Nh*SxUh)
  indice <- (1:length(nh))
  SxUh2  <- SxUh
  
  while (sum(nh>Nh)>0) {
    indice<- ifelse(nh<=Nh,indice,NA)
    SxUh2[is.na(indice)]<- NA
    Nhpro <- Nh[is.na(indice)]
    ncor  <- n-sum(Nhpro)
    nhcor <- ncor*Nh*SxUh2/sum(Nh*SxUh2,na.rm=TRUE)
    nh    <- ifelse(is.na(nhcor),Nh,nhcor)
  }
  salida<- sum(((Nh^2)/nh)*(1-(nh/Nh))*SyUh2)
  salida
}
