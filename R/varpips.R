varpips <-
function(y,x,n) {
  pik<- pinc(n,x)
  N<- sum(pik<1)
  term1<- sum((y^2)*(1-pik)/pik); term2<- sum(y*(1-pik)); term3<- sum(pik*(1-pik))
  N*(term1-((term2^2)/term3))/(N-1)
}
