stratvar <-
function(x,sk=3,n,H,d2,d4,b2=d2,b4=d4,b0=0,b1=1,rho=NULL,b3=NULL,it=1) {
  salida<- matrix(0,it,17)
  if (length(x)==1) {
     N<- x
     parametros<- c(N,n,H,b0,b1,b2,b4,d2,d4)
     for (i in 1:it) {
        x<- 1+sort(rgamma(x,shape= 4/(sk^2),scale=12*(sk^2)))
        if (!is.null(rho)) {
          term1<- max(0,(((covp(x,x^b2)^2)/((rho^2)*varp(x)))-varp(x^b2))/mean(x^(2*b4)))
          b3<- abs(b1)*sqrt(term1)
        }
        tz<- sum(x^d2)
        tz2<- sum(x^(2*d2))
        sk0<- skewness(x)
        estrato1<- stratify(x^d2,H)
        estrato5<- stratify(x^d4,H)
        H1<- max(estrato1)
        X1<- t(1*outer(estrato1,names(table(estrato1)),"=="))

        y<- simulatey(x,b0,b1,b2,b4,b3=b3)
        correla<- cor(x,y)
        ty<- sum(y)
        tzy<- sum((x^d2)*y)
        B2<- (N*tzy-tz*ty)/(N*tz2-tz*tz)
        B1<- (ty-B2*tz)/N
        E1<- y-B1-B2*(x^d2)
        B0<- matrix(by(y,estrato1,mean),H1,1)
        E2<- as.vector(y-(t(X1)%*%B0))
        
        variance1<- varpips(n,x^d4,E1)$variance          #Strategy 1. PIps-reg
        variance2<- varstsi(n,x^d4,E1,estrato5)$variance #Strategy 2. STSI-reg
        variance3<- varstsi(n,x^d2,y,estrato1)$variance  #Strategy 3. STSI-pi
        variance4<- varpips(n,x^d4,E2)$variance          #Strategy 4. PIps-pos
        variance5<- varstsi(n,x^d4,E2,estrato5)$variance #Strategy 5. STSI-pos

        varianzas<- c(b3,sk0,correla,variance1,variance2,variance3,variance4,variance5)
        salida[i,]<- c(parametros,varianzas)
    }
  } else {
    sk<- skewness(x)
    N<- length(x)
    if (!is.null(rho)) {
      term1<- max(0,(((covp(x,x^b2)^2)/((rho^2)*varp(x)))-varp(x^b2))/mean(x^(2*b4)))
      b3<- abs(b1)*sqrt(term1)
    }
    estrato1<- stratify(x^d2,H)
    estrato5<- stratify(x^d4,H)
    H1<- max(estrato1)
    tz<- sum(x^d2)
    tz2<- sum(x^(2*d2))
    X1<- t(1*outer(estrato1,names(table(estrato1)),"=="))
    parametros<- c(N,n,H,b0,b1,b2,b4,d2,d4,b3,sk)
    for (i in 1:it) {
        y<- simulatey(x,b0,b1,b2,b4,b3=b3)
        correla<- cor(x,y)
        ty<- sum(y)
        tzy<- sum((x^d2)*y)
        B2<- (N*tzy-tz*ty)/(N*tz2-tz*tz)
        B1<- (ty-B2*tz)/N
        E1<- y-B1-B2*(x^d2)
        B0<- matrix(by(y,estrato1,mean),H1,1)
        E2<- as.vector(y-(t(X1)%*%B0))

        variance1<- varpips(n,x^d4,E1)$variance          #Strategy 1. PIps-reg
        variance2<- varstsi(n,x^d4,E1,estrato5)$variance #Strategy 2. STSI-reg
        variance3<- varstsi(n,x^d2,y,estrato1)$variance  #Strategy 3. STSI-pi
        variance4<- varpips(n,x^d4,E2)$variance          #Strategy 4. PIps-pos
        variance5<- varstsi(n,x^d4,E2,estrato5)$variance #Strategy 5. STSI-pos

        varianzas<- c(correla,variance1,variance2,variance3,variance4,variance5)
        salida[i,]<- c(parametros,varianzas)
    }
}
  salida<- as.data.frame(salida)
  names(salida)<- c("N","n","H","b0","b1","b2","b4","d2","d4","b3","sk","cor",
                    "PIps-reg","STSI-reg","STSI-HT","PIps-pos","STSI-pos")
  salida
}
