optiallo <-
function(n,x,stratum=NULL,...) {
  if (is.null(stratum)) {stratum<- stratify(x,...)}
  SxUh   <- as.vector(by(x,stratum,sd))
  SxUh[is.na(SxUh)]  <- sum(SxUh,na.rm=TRUE)
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
  stratum2<- names(table(stratum))
  nh<- nh[match(stratum,stratum2)]
  list(stratum=stratum,nh=nh)
}
