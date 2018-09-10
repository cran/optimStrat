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
 
  estrato1<- reactive({stratify(x()^input$delta2,input$H)})
  estrato2<- reactive({stratify(x()^input$delta4,input$H)})
 
  y<- reactive({simulatey(x(),b0=input$beta0,b1=input$beta1,b2=input$beta2,b4=input$beta4,rho=input$rho)})
  
  betaest<- reactive({
    x2<- x()^input$delta2
    z<- lm(y()~x2)
    if (input$beta2==input$delta2) {z$coefficients<- c(input$beta0,input$beta1)}
    as.vector(z$coefficients)
  })
 
  observeEvent(input$go,{
    output$grafico1<- renderPlot({hist(x(),nclass=sqrt(length(x())),freq=FALSE,las=1,xlab="x",main="")
  })
 
  output$tabla1<- renderPrint({
    salida<- c(length(x()),mean(x()),var(x()),skewness(x()))
    names(salida)<- c("N","Mean_x","Var_x","Sk_x")
    salida
  })
 
  output$grafico2<- renderPlot({
    delta3<- (1/16)*(max(x())^(2*(input$delta2-input$delta4)))
    x <- seq(0,max(x()),length=1001)
    y <- x^input$delta2
    y2<- (x^input$delta2)-sqrt(delta3)*(x^input$delta4)
    y3<- (x^input$delta2)+sqrt(delta3)*(x^input$delta4)
    plot(x,y,type="n",xlab="x",ylab="y",xlim=c(0,max(x)),ylim=c(min(0,min(y2)),max(y3)),axes=FALSE)
    axis(1)
    polygon(c(x[input$N:1],x),c(y2[input$N:1],y3),col=rgb(255,200,200,maxColorValue=255),border=NA)
    points(x,y ,type="l",col="red",lwd=2)
  })

  output$grafico3<- renderPlot({
    y<- density(x())
    H1<- max(estrato1())
    cortes <- c(min(y$x),(by(x(),estrato1(),min)[-1]+by(x(),estrato1(),max)[-H1])/2,max(y$x))
    cortes3<- unique(cortes)
    cortes2<- cut(y$x,cortes3,labels=FALSE,include.lowest=TRUE)
    basura <- c(as.vector(by(cortes2,cortes2,mean)),length(cortes3))
    cortes3<- cortes3[basura]
    maxe   <- by(y$y,cortes2,max)
    plot(y,main="",xlab="x",las=1,lwd=2)
    segments(min(y$x),0,max(y$x),0,col=3,lwd=2)
    segments(cortes3[-length(cortes3)],maxe,cortes3[-1],maxe,col=3,lwd=2)
    segments(cortes3,0,cortes3,pmax(c(0,maxe),c(maxe,0)),col=3,lwd=2)
  })
  
  output$grafico4<- renderPlot({
    y      <- density(x())
    H2<- max(estrato2())
    cortes <- c(min(y$x),(by(x(),estrato2(),min)[-1]+by(x(),estrato2(),max)[-H2])/2,max(y$x))
    cortes3<- unique(cortes)
    cortes2<- cut(y$x,cortes3,labels=FALSE,include.lowest=TRUE)
    basura <- c(as.vector(by(cortes2,cortes2,mean)),length(cortes3))
    cortes3<- cortes3[basura]
    maxe   <- by(y$y,cortes2,max)
    plot(y,main="",xlab="x",las=1,lwd=2)
    segments(min(y$x),0,max(y$x),0,col=3,lwd=2)
    segments(cortes3[-length(cortes3)],maxe,cortes3[-1],maxe,col=3,lwd=2)
    segments(cortes3,0,cortes3,pmax(c(0,maxe),c(maxe,0)),col=3,lwd=2)
  })
 
  output$tabla2<- renderTable({
    y <- density(x())
    H1<- max(estrato1())
    H2<- max(estrato2())
    bound12<- c(min(x()),as.vector(by(x(),estrato1(),min)[-1]+by(x(),estrato1(),max)[-H1])/2,max(x()))
    bound22<- c(min(x()),as.vector(by(x(),estrato2(),min)[-1]+by(x(),estrato2(),max)[-H2])/2,max(x()))
    N12    <- c(NA,as.vector(table(estrato1())))
    N22    <- c(NA,as.vector(table(estrato2())))
    maxi<- max(length(bound12),length(N12),length(bound22),length(N22))
    bound1<- rep(NA,maxi)
    bound2<- rep(NA,maxi)
    N1<- rep(NA,maxi)
    N2<- rep(NA,maxi)
    bound1[1:length(bound12)]<- bound12
    bound2[1:length(bound22)]<- bound22
    N1[1:length(N12)]<- N12
    N2[1:length(N22)]<- N22
    salida<- data.frame(bound1,N1,bound2,N2)
    names(salida)<- c("x(st3)","N(st3)","x(st2)","N(st2)")
    salida
  })
 
  output$grafico5<- renderPlot({
    x<- seq(0,1.1*max(x()),length=1001)
    y <- input$beta0+input$beta1*(x^input$beta2)
    y2<- input$beta0+input$beta1*(x^input$beta2)-beta3()*(x^input$beta4)
    y3<- input$beta0+input$beta1*(x^input$beta2)+beta3()*(x^input$beta4)
 
    delta3<- beta3()*(max(x())^(input$beta4-input$delta4))
    y0 <- betaest()[1]+betaest()[2]*(x^input$delta2)
    y02<- betaest()[1]+betaest()[2]*(x^input$delta2)-delta3*(x^input$delta4)
    y03<- betaest()[1]+betaest()[2]*(x^input$delta2)+delta3*(x^input$delta4)
 
    plot   (x,pmax(y3,y03),type="n",xlab="x",ylab="y",ylim=c(min(0,y2,y02),max(y3,y03)),xlim=c(0,max(x())),bty="c")
    abline (h=0,col="gray",lwd=0.5)
    polygon(c(x[input$N:1],x),c(y2[input$N:1],y3),col=rgb(200,255,200,maxColorValue=255),border=NA)
    points (x,y ,type="l",col="green",lwd=2)
    polygon(c(x[input$N:1],x),c(y02[input$N:1],y03),col=rgb(255,200,200,maxColorValue=255),border=NA)
    points (x,y0,type="l",col="red",lwd=2)
  })
 
  output$grafico6<- renderPlot({
    muestra<- sample(1:N(),min(N(),5000))
    x <- seq(0,1.1*max(x()),length=1001)
    y <- input$beta0+input$beta1*(x^input$beta2)
    y2<- input$beta0+input$beta1*(x^input$beta2)-beta3()*(x^input$beta4)
    y3<- input$beta0+input$beta1*(x^input$beta2)+beta3()*(x^input$beta4)
 
    delta3<- beta3()*(max(x())^(input$beta4-input$delta4))
    y0    <- betaest()[1]+betaest()[2]*(x^input$delta2)
    y02   <- betaest()[1]+betaest()[2]*(x^input$delta2)-delta3*(x^input$delta4)
    y03   <- betaest()[1]+betaest()[2]*(x^input$delta2)+delta3*(x^input$delta4)
 
    plot   (x,y3,type="n",xlab="x",ylab="y",ylim=c(min(0,y2,y02,y()),max(y3,y03,y())),xlim=c(0,max(x())),bty="c")
    abline (h=0,col="gray",lwd=0.5)
#    polygon(c(x[input$N:1],x),c(y2[input$N:1],y3),col=rgb(200,255,200,maxColorValue=255),border=NA)
#    points (x,y ,type="l",col="green",lwd=2)
    polygon(c(x[input$N:1],x),c(y02[input$N:1],y03),col=rgb(255,200,200,maxColorValue=255),border=NA)
    points (x,y0,type="l",col="red",lwd=2)
    points (x()[muestra],y()[muestra],xlab="x",ylab="y")
#plot (x()[muestra],y()[muestra],xlab="x",ylab="y")
  })
 
  output$tabla3<- renderTable({
    linea1<- c("x",mean(x()),var(x()),skewness(x()),cor(x(),y()))
    linea2<- c("y",mean(y()),var(y()),skewness(y()),NA)
    x     <- data.frame(rbind(linea1,linea2))
    names(x)   <- c("Variable","Mean","Variance","Skewness","Correlation")
    rownames(x)<- NULL
    x
  })
 
  varianzas<- reactive({
    if (xind()==1) {
      stratvar(x(),0,input$nn,input$H,input$delta2,input$delta4,input$beta2,input$beta4,input$beta0,input$beta1,input$rho,it=1)
    } else {
      stratvar(N(),input$sk,input$nn,input$H,input$delta2,input$delta4,input$beta2,input$beta4,input$beta0,input$beta1,input$rho,it=1)
    }
  })
    
  output$varianza1<- renderText({as.numeric(varianzas()[13])})
  output$varianza2<- renderText({as.numeric(varianzas()[14])})
  output$varianza3<- renderText({as.numeric(varianzas()[15])})
  output$varianza4<- renderText({as.numeric(varianzas()[16])})
  output$varianza5<- renderText({as.numeric(varianzas()[17])})
  output$varianza6<- renderText({as.numeric(round(100*varianzas()[13]/varianzas()[15],2))})
  output$varianza7<- renderText({as.numeric(round(100*varianzas()[14]/varianzas()[15],2))})
  output$varianza8<- renderText({as.numeric(round(100*varianzas()[15]/varianzas()[15],2))})
  output$varianza9<- renderText({as.numeric(round(100*varianzas()[16]/varianzas()[15],2))})
  output$varianza0<- renderText({as.numeric(round(100*varianzas()[17]/varianzas()[15],2))})
   
  observeEvent(input$itera,{
    if (xind()==1) {resulta<- stratvar(x(),input$sk,input$nn,input$H,input$delta2,input$delta4,input$beta2,input$beta4,input$beta0,input$beta1,
                                       input$rho,it=round(input$it))
    } else {resulta<- stratvar(N(),input$sk,input$nn,input$H,input$delta2,input$delta4,input$beta2,input$beta4,input$beta0,input$beta1,input$rho,
                               it=round(input$it))
    }
    muestra<- min(10,round(input$it))
    maxi   <- max(resulta[,13:17])
    
    output$tabla5  <- renderText({"The results of the iterations can be found in the file 'Iterations.csv'"})
    output$tabla6  <- renderPrint({print(resulta[1:muestra,])})
    output$downdata<- downloadHandler(filename="Iterations.csv",content=function(file) {
      write.table(resulta,file,row.names=FALSE,sep=",",dec=".")
    })
    output$grafico7<- renderPlot({
      cosa<- boxplot(resulta[,13:17],plot=FALSE)
      ymax   <- 2*max(sort(cosa$stats[4,]))
      boxplot(resulta[,13:17],las=1,ylim=c(0,min(ymax,max(resulta[,13:17]))))
    })
  })
})
}