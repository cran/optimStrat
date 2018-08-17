covp <-
function(x,y) {
   n<- length(x)
   cov(x,y)*(n-1)/n
}
