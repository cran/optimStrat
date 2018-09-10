simulatey <-
function(x,b0,b1,b2,b4,rho=NULL,b3=NULL) {
  N<- length(x)
  if (!is.null(rho)) {
    term1<- max(0,(((covp(x,x^b2)^2)/((rho^2)*varp(x)))-varp(x^b2))/mean(x^(2*b4)))
    b3<- abs(b1)*sqrt(term1)
  }
  error<- rnorm(N,0,b3*(x^b4))
  b0+(b1*(x^b2))+error
}
