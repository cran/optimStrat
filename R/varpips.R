varpips <-
function(n,x,y) {
  N<- length(x)
  pik<- n*x/sum(x)
  while (max(pik)>1) {pik<- ifelse(pik>1,1,pik); pik[pik<1]<- (n-sum(pik==1))*pik[pik<1]/sum(pik[pik<1])}
  term1<- sum((y^2)*(1-pik)/pik); term2<- sum(y*(1-pik)); term3<- sum(pik*(1-pik))
  variance<- N*(term1-((term2^2)/term3))/(N-1)
  list(variance=variance,pinc=pik)
}
