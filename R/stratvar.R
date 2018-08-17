stratvar<- 
function(x,sk=3,H,n,b0,b1,b2,b3,b4,d2=b2,d4=b4,it=1) {
  salida<- matrix(0,it,17)
  if (length(x)==1) {
     N<- x
     parametros<- c(N,sk,H,n,b0,b1,b2,b3,b4,d2,d4)
     for (i in 1:it) {
        x<- 1+sort(rgamma(x,shape= 4/(sk^2),scale=12*(sk^2)))
        pik5<- n*(x^d4)/sum(x^d4)
        while (max(pik5)>1) {pik5<- ifelse(pik5>1,1,pik5); pik5[pik5<1]<- (n-sum(pik5==1))*pik5[pik5<1]/sum(pik5[pik5<1])}
        y<- simulatey(x,b0,b1,b2,b3,b4)
        correla<- cor(x,y)

        #Strategy 1: PIps-reg
        tz<- sum(x^d2)
        ty<- sum(y)
        tz2<- sum(x^(2*d2))
        tzy<- sum((x^d2)*y)
        B2<- (N*tzy-tz*ty)/(N*tz2-tz*tz)
        B1<- (ty-B2*tz)/N
        E1<- y-B1-B2*(x^d2)

        term1<- sum((E1^2)*(1-pik5)/pik5); term2<- sum(E1*(1-pik5)); term3<- sum(pik5*(1-pik5))
        variance1<- N*(term1-((term2^2)/term3))/(N-1)

        #Strategy 2: STSI-reg
        estrato5<- stratify(x^d4,H)
        variance2<- optiallo(n,x^d4,E1,estrato5)

        #Strategy 4. PIps-pos
        estrato1<- stratify(x^d2,H)
        H1<- max(estrato1)
        X1<- t(1*outer(estrato1,names(table(estrato1)),"=="))
        B2<- matrix(by(y,estrato1,mean),H1,1)
        E2<- as.vector(y-(t(X1)%*%B2))
        term1<- sum((E2^2)*(1-pik5)/pik5); term2<- sum(E2*(1-pik5)); term3<- sum(pik5*(1-pik5))
        variance4<- N*(term1-((term2^2)/term3))/(N-1)

        #Strategy 5. STSI-pos
        variance5<- optiallo(n,x^d4,E2,estrato5)

        #Strategy 3. STSI-pi
        variance3<- optiallo(n,x^d2,y,estrato1)

        varianzas<- c(correla,variance1,variance2,variance3,variance4,variance5)
        salida[i,]<- c(parametros,varianzas)
    }
  } else {
    sk<- skewness(x)
    N<- length(x)
    pik5<- n*(x^d4)/sum(x^d4)
    while (max(pik5)>1) {pik5<- ifelse(pik5>1,1,pik5); pik5[pik5<1]<- (n-sum(pik5==1))*pik5[pik5<1]/sum(pik5[pik5<1])}
    estrato1<- stratify(x^d2,H)
    estrato5<- stratify(x^d4,H)
    H1<- max(estrato1)
    tz<- sum(x^d2)
    tz2<- sum(x^(2*d2))
    X1<- t(1*outer(estrato1,names(table(estrato1)),"=="))
    parametros<- c(N,sk,H,n,b0,b1,b2,b3,b4,d2,d4)
    for (i in 1:it) {
        y<- simulatey(x,b0,b1,b2,b3,b4)
        correla<- cor(x,y)

        #Strategy 1: PIps-reg
        ty<- sum(y)
        tzy<- sum((x^d2)*y)
        B2<- (N*tzy-tz*ty)/(N*tz2-tz*tz)
        B1<- (ty-B2*tz)/N
        E1<- y-B1-B2*(x^d2)

        term1<- sum((E1^2)*(1-pik5)/pik5); term2<- sum(E1*(1-pik5)); term3<- sum(pik5*(1-pik5))
        variance1<- N*(term1-((term2^2)/term3))/(N-1)

        #Strategy 2: STSI-reg
        variance2<- optiallo(n,x^d4,E1,estrato5)

        #Strategy 4. PIps-pos
        B2<- matrix(by(y,estrato1,mean),H1,1)
        E2<- as.vector(y-(t(X1)%*%B2))
        term1<- sum((E2^2)*(1-pik5)/pik5); term2<- sum(E2*(1-pik5)); term3<- sum(pik5*(1-pik5))
        variance4<- N*(term1-((term2^2)/term3))/(N-1)

        #Strategy 5. STSI-pos
        variance5<- optiallo(n,x^d4,E2,estrato5)

        #Strategy 3. STSI-pi
        variance3<- optiallo(n,x^d2,y,estrato1)

        varianzas<- c(correla,variance1,variance2,variance3,variance4,variance5)
        salida[i,]<- c(parametros,varianzas)
    }
}
  salida<- as.data.frame(salida)
  names(salida)<- c("N","sk","H","n","b0","b1","b2","b3","b4","d2","d4","cor",
                    "PIps-reg","STSI-reg","STSI-HT","PIps-pos","STSI-pos")
  salida
}
