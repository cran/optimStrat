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
  if (K<=H) {stratum<- x}
  if (K>H) {
    cortes<- seq(min(x),max(x),length=J+1)
    frecuencia <-  hist(x,cortes,plot=FALSE,include.lowest=TRUE,right=FALSE)$counts/N
    frecuencia2<- frecuencia^0.5
    cumu       <- cumsum(frecuencia2)
    cortes2<- (cortes[-1]+cortes[-length(cortes)])*0.5
    cortes2<- c(min(x),cortes2[-length(cortes2)],max(x))
    cumu2<- c(0,cumu)
    yh<- sum(frecuencia2)*(1:H)/H
    j<- findInterval(yh,cumu2,rightmost.closed=TRUE)
    term1<- (yh-cumu2[j])/(cumu2[j+1]-cumu2[j]); term1[is.nan(term1)]<- 1
    cortes3<- cortes2[j]+term1*(cortes2[j+1]-cortes2[j])
    cortes<- c(-Inf,cortes3[-length(cortes3)],Inf)
    stratum<- cut(x,cortes,labels=FALSE,include.lowest=TRUE,right=FALSE)
  }
  H2<- length(table(stratum))
  while (K<H&H<N&forced==TRUE&H2<H) {
    esti<- as.vector(by(stratum,stratum,mean))
    frei<- as.vector(by(stratum,stratum,length))
    esti<- esti[frei==max(frei)]; esti<- esti[length(esti)]
    frei<- frei[frei==max(frei)]; frei<- floor(frei[length(frei)]/2)
    indica<- (1:N)*(stratum==esti); indica[indica==0]<- NA
    maxi<- max(indica,na.rm=TRUE); mini<- min(indica,na.rm=TRUE)
    stratum[stratum==esti&indica<=(maxi+mini)/2]<- max(stratum)+1
    H2<- length(table(stratum))
  }
  if (K<H&H==N&forced==TRUE) {stratum<- 1:N}
  while (H<K&forced==TRUE&H2<H) {
    esti<- as.vector(by(stratum,stratum,mean))
    vari<- as.vector(by(x,stratum,var)); vari[is.na(vari)]<- 0
    x2<- esti[vari==max(vari)]
    x2<- x[stratum==x2[1]]
    esti<- as.vector(by(x2,x2,mean))
    x2<- as.vector(by(x2,x2,length))
    esti<- esti[x2==max(x2)]
    stratum[x==esti[1]]<- max(stratum)+1
    H2<- length(table(stratum))
  }
  while (H<K&forced==TRUE&H2>H) {
    esti<- as.vector(by(stratum,stratum,mean))
    vari<- as.vector(by(x,stratum,var)); vari[is.na(vari)]<- 0
    enes<- as.vector(by(x,stratum,length))
    esti1<- esti[-length(esti)]; esti2<- esti[-1]
    vari1<- vari[-length(esti)]; vari2<- vari[-1]
    enes1<- enes[-length(esti)]; enes2<- enes[-1]
    pool<- ((enes1-1)*vari1+(enes2-1)*vari2)/(enes1+enes2-2)
    esti1<- esti1[pool==min(pool)]
    esti2<- esti2[pool==min(pool)]
    stratum[stratum==esti2[1]]<- esti1[1]
    H2<- length(table(stratum))
  }
  stratum2<- unique(stratum)
  stratum <- match(stratum,stratum2)
  stratum[order(id)]
}
