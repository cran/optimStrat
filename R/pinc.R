pinc <-
function(n,x) {
  x1<- sign(min(x)); x2<- sign(max(x))
  if (x1*x2==-1) {stop("All the x-values must be either non-negative or non-positive")}
  N<- length(x)
  pik<- n*x/sum(x)
  while (max(pik)>1) {pik<- ifelse(pik>1,1,pik); pik[pik<1]<- (n-sum(pik==1))*pik[pik<1]/sum(pik[pik<1])}
  pik
}
