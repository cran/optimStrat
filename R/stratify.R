stratify <-
function(x,H,forced=FALSE,J=NULL) {
  N<- length(x)
  if (is.null(J)) {J<- max(H^2,round(sqrt(N)))}
  id<- 1:N
  id<- id[order(x)]
  K<- length(table(x))
  if (K==N) {x<- sort(x)} else {
    x2<- as.vector(by(x,x,length))
    x <- as.vector(by(x,x,mean))
    x<- rep(x,times=x2)
  }
  
  if (N<H) {forced<- FALSE}
  if (K<=H) {estrato<- x}
  if (K>H) {
    cortes<- seq(min(x),max(x),length=J+1)
    frecuencia <-  hist(x,cortes,plot=FALSE,include.lowest=TRUE,right=FALSE)$counts/N
    frecuencia2<- frecuencia^0.5
    cumu       <- cumsum(frecuencia2)
    compara    <- outer(cumu,sum(frecuencia2)*(1:H)/H,absdif)
    basura     <- matrix(apply(compara,2,min),J,H,byrow=TRUE)
    filas      <- matrix(1:J,J,H)
    compara2   <- compara==basura
    cortes2    <- c(min(x),cortes[-1][filas[compara2==1]])
    cortes2    <- unique(cortes2)
    estrato    <- cut(x,cortes2,labels=FALSE,include.lowest=TRUE,right=FALSE)
  }
  H2<- length(table(estrato))
  while (K<H&H<N&forced==TRUE&H2<H) {
    esti<- as.vector(by(estrato,estrato,mean))
    frei<- as.vector(by(estrato,estrato,length))
    esti<- esti[frei==max(frei)]; esti<- esti[length(esti)]
    frei<- frei[frei==max(frei)]; frei<- floor(frei[length(frei)]/2)
    indica<- (1:N)*(estrato==esti); indica[indica==0]<- NA
    maxi<- max(indica,na.rm=TRUE); mini<- min(indica,na.rm=TRUE)
    estrato[estrato==esti&indica<=(maxi+mini)/2]<- max(estrato)+1
    H2<- length(table(estrato))
  }
  if (K<H&H==N&forced==TRUE) {estrato<- 1:N}
  while (H<K&forced==TRUE&H2<H) {
    esti<- as.vector(by(estrato,estrato,mean))
    vari<- as.vector(by(x,estrato,var)); vari[is.na(vari)]<- 0
    x2<- esti[vari==max(vari)]
    x2<- x[estrato==x2[1]]
    esti<- as.vector(by(x2,x2,mean))
    x2<- as.vector(by(x2,x2,length))
    esti<- esti[x2==max(x2)]
    estrato[x==esti[1]]<- max(estrato)+1
    H2<- length(table(estrato))
  }
  while (H<K&forced==TRUE&H2>H) {
    esti<- as.vector(by(estrato,estrato,mean))
    vari<- as.vector(by(x,estrato,var)); vari[is.na(vari)]<- 0
    enes<- as.vector(by(x,estrato,length))
    esti1<- esti[-length(esti)]; esti2<- esti[-1]
    vari1<- vari[-length(esti)]; vari2<- vari[-1]
    enes1<- enes[-length(esti)]; enes2<- enes[-1]
    pool<- ((enes1-1)*vari1+(enes2-1)*vari2)/(enes1+enes2-2)
    esti1<- esti1[pool==min(pool)]
    esti2<- esti2[pool==min(pool)]
    estrato[estrato==esti2[1]]<- esti1[1]
    H2<- length(table(estrato))
  }
  estrato2<- unique(estrato)
  estrato <- match(estrato,estrato2)
  estrato[order(id)]
}
