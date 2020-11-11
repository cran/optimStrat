function(input,output) {
  v<- reactiveValues(doPlot = FALSE)
  
  observeEvent(input$go, {v$doPlot<- input$go})
  
  observeEvent(input$tabset,{v$doPlot <- FALSE})  
  
  x<- reactive({
    if (v$doPlot == FALSE) return()
    isolate({data<- if (input$tabset=="Select") {
      inFile<- input$select
      if (is.null(inFile)) {return(NULL)}
      datos<- read.table(inFile$datapath,sep=",",dec=".")
      sort(datos$V1)
      } else {1+sort(rgamma(round(input$N),shape=4/(input$sk^2),scale=12*(input$sk^2)))}
    })
  })
 
  N<- reactive({length(x())})

  beta3<- reactive({
    term1<- max(0,(((covp(x(),x()^input$beta2)^2)/((input$rho^2)*varp(x())))-varp(x()^input$beta2))/mean(x()^(2*input$beta4)))
    abs(input$beta1)*sqrt(term1)
  })
 
  xind<- reactive({
    if (v$doPlot == FALSE) return()
    isolate({data<- if (input$tabset=="Select") {1} else {2}})
  })
 
  estrato1<- reactive({optiallo(input$nn,x()^input$delta2,H=input$H)})
  estrato2<- reactive({optiallo(input$nn,x()^input$delta4,H=input$H)})
 
  observeEvent(input$go,{
    output$grafico1<- renderPlot({hist(x(),nclass=sqrt(length(x())),freq=FALSE,las=1,xlab="x",main="")
  })
 
  output$tabla1<- renderPrint({
    salida<- c(length(x()),mean(x()),var(x()),skewness(x()))
    names(salida)<- c("N","Mean_x","Var_x","Sk_x")
    salida
  })
 
  output$grafico2<- renderPlot({
    delta3<- (cov(x(),x()^input$delta2)^2)*((1/(input$rho^2))-(1/(cor(x(),x()^input$delta2)^2)))/(mean(x()^(2*input$delta4))*var(x()))
    delta3<- max(delta3,0)
    x <- seq(0,max(x()),length=1001)
    y <- x^input$delta2
    y2<- (x^input$delta2)-sqrt(delta3)*(x^input$delta4)
    y3<- (x^input$delta2)+sqrt(delta3)*(x^input$delta4)
    plot(x,y,type="n",xlab="x",ylab="y",xlim=c(0,max(x)),ylim=c(min(0,min(y2)),max(y3)),axes=FALSE)
    axis(1)
    polygon(c(x[1001:1],x),c(y2[1001:1],y3),col=rgb(255,200,200,maxColorValue=255),border=NA)
    points(x,y ,type="l",col="red",lwd=2)
  })

  output$tab_variance<- renderPrint({
   d<- c(input$delta2,input$delta4)
   varb1<- min((d[1]/3.8906)^2,input$sigma1)
   varb2<- min((d[2]/3.8906)^2,input$sigma2)
   covb<- input$rho12*sqrt(varb1)*sqrt(varb2)
   Sigma<- matrix(c(varb1,covb,covb,varb2),2,2)
   Sigma
  })

  output$gra_density<- renderPlot({
   y <- density(x())
   d<- c(input$delta2,input$delta4)
   varb1<- min((d[1]/3.8906)^2,input$sigma1)
   varb2<- min((d[2]/3.8906)^2,input$sigma2)
   covb<- input$rho12*sqrt(varb1)*sqrt(varb2)

   li1<- qnorm(0.0001/2,d[1],sqrt(varb1))
   ls1<- qnorm(1-(0.0001/2),d[1],sqrt(varb1))
   li2<- qnorm(0.0001/2,d[2],sqrt(varb2))
   ls2<- qnorm(1-(0.0001/2),d[2],sqrt(varb2))

   Sigma<- matrix(c(varb1,covb,covb,varb2),2,2)

   seq1<- seq(li1,ls1,length=51)
   seq2<- seq(li2,ls2,length=51)

   dmvnorm2<- function(b1,b2) {
      if (input$rho12==0) {dnorm(b1,d[1],sqrt(varb1))*dnorm(b2,d[2],sqrt(varb2))} else {dmvnorm(c(b1,b2),d,Sigma)}
   }
   proba<- function(b1,b2) {as.numeric(pchisq((c(b1,b2)-d)%*%solve(Sigma)%*%t(t(c(b1,b2)-d)),2))}

   matriz<- expand.grid(seq1,seq2)
   matriz$Density<- mapply(dmvnorm2,matriz$Var1,matriz$Var2)
   matriz$Proba<- mapply(proba,matriz$Var1,matriz$Var2)

   matrizd<- matrix(matriz$Density,51,51)
   matrizp<- matrix(matriz$Proba,51,51)

   image(seq1,seq2,z=matrizd,xlab="b1,2",ylab="b2",main="",col=terrain.colors(50),las=1)
   contour(seq1,seq2,z=matrizp,xlab="",ylab="",main="",add=TRUE,levels=c(0.5,0.9,0.95,0.99),labcex=1)
  })

  output$down_data<- downloadHandler(filename="Design.csv",content=function(file) {
     pik<- pinc(input$nn,x())
     resulta<- data.frame(x(),pik,estrato1()$stratum,estrato1()$nh,estrato2()$stratum,estrato2()$nh)
     names(resulta)<- c("x","PIk","st_d12","nh_d12","st_d2","nh_d2")
     write.table(resulta,file,row.names=FALSE,sep=",",dec=".")
  })

  matriz7<- reactiveValues(matriz5=matrix(0,11,11),seq1=seq(0,1,length=11),seq2=seq(0,1,length=11),risk=numeric(10),mejor="")

 observeEvent(input$calcula,{
   dmvnorm2<- function(b1,b2) {
      if (input$rho12==0) {dnorm(b1,d[1],sqrt(varb1))*dnorm(b2,d[2],sqrt(varb2))} else {dmvnorm(c(b1,b2),d,Sigma)}
   }
    integra<- function(b, d, x, n, H, Rxy,indica) {expvar(b, d, x, n, H, Rxy,estrato1(),estrato2(),indica,short=TRUE)*dmvnorm2(b[1],b[2])}
    d<- c(input$delta2,input$delta4)
    varb1<- min((d[1]/3.8906)^2,input$sigma1)
    varb2<- min((d[2]/3.8906)^2,input$sigma2)
    covb<- input$rho12*sqrt(varb1)*sqrt(varb2)

    li1<- qnorm(0.0001/2,d[1],sqrt(varb1))
    ls1<- qnorm(1-(0.0001/2),d[1],sqrt(varb1))
    li2<- qnorm(0.0001/2,d[2],sqrt(varb2))
    ls2<- qnorm(1-(0.0001/2),d[2],sqrt(varb2))

    Sigma<- matrix(c(varb1,covb,covb,varb2),2,2)

    expecta<- numeric(5)

    matriz7$seq1<- seq(li1,ls1,length=11)
    matriz7$seq2<- seq(li2,ls2,length=11)
    matriz<- expand.grid(matriz7$seq1,matriz7$seq2)
    matriz5<- matrix(0,nrow(matriz),5)
    J<- nrow(matriz)

    withProgress(message='Progress', value = 0, {
      for (i in 1:5) {
        expecta[i]<- hcubature(integra,c(li1,li2),c(ls1,ls2),tol=1e-2,d=d,x=x(),n=input$nn,H=input$H,Rxy=input$rho,indica=i)$integral
        incProgress(1/10)
      }
      for (i in 1:J) {
        matriz5[i,]<- expvar(c(matriz$Var1[i],matriz$Var2[i]), d, x(), input$nn, input$H, input$rho,estrato1(),estrato2())
        incProgress(1/(2*J))
      }
    })

    expecta2<- expecta/expecta[3]
    nombres<- c("PIPS-reg","STSI-reg","STSI-HT","PIPS-pos","STSI-pos")
    matriz7$mejor<- nombres[which.min(expecta)]
    matriz7$risk<- c(expecta,expecta2)
    matriz7$matriz5<- matriz5
 })

  output$gra_loss<- renderPlot({
    matriz5<- matriz7$matriz5
    matriz1<- matrix(matriz5[,1],11,11)
    matriz2<- matrix(matriz5[,2],11,11)
    matriz3<- matrix(matriz5[,3],11,11)
    matriz4<- matrix(matriz5[,4],11,11)
    matriz5<- matrix(matriz5[,5],11,11)
    matriz0<- matrix(0,11,11)

    Matriz<- list(matriz1,matriz2,matriz3,matriz4,matriz5,matriz0)
    nombres<- c("PIPS-reg","STSI-reg","STSI-HT","PIPS-pos","STSI-pos","---")

    i<- as.numeric(input$compare1); j<- as.numeric(input$compare2)
    matriz6<- Matriz[[i]]-Matriz[[j]]
    matriz6<- log(abs(matriz6))*sign(matriz6)
    matriz6[is.nan(matriz6)]<- 0
    zlim<- range(matriz6); if (zlim[1]==zlim[2]) {zlim[1]<- zlim[1]-1; zlim[2]<- zlim[2]+1}
    persp(matriz7$seq1,matriz7$seq2,z=matriz6,xlab="b1,2",ylab="b2",zlab="",main="",
       theta=input$theta,phi=input$phi,col="yellow",ticktype = "detailed",zlim=zlim)
  })

  output$risk1<- renderText({matriz7$risk[1]})
  output$risk2<- renderText({matriz7$risk[2]})
  output$risk3<- renderText({matriz7$risk[3]})
  output$risk4<- renderText({matriz7$risk[4]})
  output$risk5<- renderText({matriz7$risk[5]})
  output$risk6<- renderText({round(matriz7$risk[6],2)})
  output$risk7<- renderText({round(matriz7$risk[7],2)})
  output$risk8<- renderText({round(matriz7$risk[8],2)})
  output$risk9<- renderText({round(matriz7$risk[9],2)})
  output$risk0<- renderText({round(matriz7$risk[10],2)})
  output$mejor<- renderText({matriz7$mejor})   
})
}