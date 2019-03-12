gk <-
function(x,Beta21,Beta22) {
   J1<- ncol(x); J2<- length(Beta21); J3<- length(Beta22)
   if (var(c(J1,J2,J3))>0) {stop("The dimensions of the arguments do not match.")}
   xb<- t(t(x)^Beta22)
   as.vector(xb%*%Beta21)
}
