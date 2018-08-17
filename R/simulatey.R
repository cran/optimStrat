simulatey <-
function(x,b0,b1,b2,b3,b4) {
  N<- length(x)
  error<- rnorm(N,0,sqrt(b3)*(x^b4))
  b0+(b1*(x^b2))+error
}
