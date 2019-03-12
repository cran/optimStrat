vk <-
function(x,Beta11,Beta12,Delta12,ak=1) {
   J1<- ncol(x);        J2<- length(Beta11);  J3<- length(Beta12);  J4<- length(Delta12)
   if (var(c(J1,J2,J3,J4))>0) {stop("The dimensions of the arguments do not match.")}
   xd<- t(t(x)^Delta12)
   xb<- t(t(x)^Beta12)
   A<- solve(t(xd/ak)%*%xd)%*%t(xd/ak)%*%xb
   list(fbk=as.vector(xb%*%Beta11),fdk=as.vector((xd%*%A)%*%Beta11))
}
