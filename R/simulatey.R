simulatey <-
function(x,f,g,dist="normal",rho=NULL,Sigma=NULL,...) {
   if (!is.null(rho)) {if (rho<0) {stop("'rho' must be nonnegative.")}}
   f<- match.fun(f)
   g<- match.fun(g)
   fx<- f(x,...)
   gx<- g(x,...)
   N<- length(fx)
   if (!is.null(rho)) {
     term1<- max(0,(((covp(x,fx)^2)/((rho^2)*varp(x)))-varp(fx))/mean(gx^2))
     Sigma<- sqrt(term1)
   }
   if ((Sigma==0|min(fx)<0)&dist=="gamma") {dist<- "normal"; print("dist converted to 'normal'")}
   if (dist=="normal") {
      error<- rnorm(N,0,Sigma*abs(gx))
      y<- fx+error
   }
   if (dist=="gamma") {
      den1<- (Sigma*gx)^2
      alpha0<- (fx^2)/den1
      lambda0<- den1/fx
      y<- rgamma(N,shape=alpha0,scale=lambda0)
   }
   return(y)
}
