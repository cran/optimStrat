skewness <-
function(x,na.rm=FALSE) {
   term1<- mean((x-mean(x,na.rm=na.rm))^3,na.rm=na.rm)
   term2<- (var(x,na.rm=na.rm))^(3/2)
   term1/term2
}
