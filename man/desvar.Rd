\name{desvar}
\alias{desvar}
\title{Design variance}
\description{Compute the design variance of six sampling strategies.}
\usage{
desvar(y, x, n, H, d2, d4)
}
\arguments{
  \item{y}{a numeric vector giving the values of the study variable.}
  \item{x}{a positive numeric vector giving the values of the auxiliary variable.}
  \item{n}{a positive integer indicating the desired sample size.}
  \item{H}{a positive integer giving the desired number of strata/poststrata.}
  \item{d2}{a number giving the \emph{assumed} shape of the trend term in the superpopulation model.}
  \item{d4}{a number giving the \emph{assumed} shape of the spread term in the superpopulation model.}
}
\details{
The design variance of a sample of size \code{n} is computed for six sampling strategies (stsi--HT, \eqn{\pi}ps--HT, stsi--pos, \eqn{\pi}ps--pos, stsi--reg and \eqn{\pi}ps--pos). The strategies are defined assuming that there is an underlying superpopulation model of the form
\deqn{Y_{k}=\delta_{0}+\delta_{1}x_{k}^{\delta_{2}}+\epsilon_{k}}{Y_k = \delta_0 + \delta_1 x_k^\delta_2 + \epsilon_k}
with \eqn{E\epsilon_{k}=0}{E\epsilon_k=0}, \eqn{V\epsilon_{k}=\delta_{3}^{2}x_{k}^{2\delta_{4}}}{V\epsilon_k=\delta_3^2 x_k^2\delta_4} and \eqn{Cov(\epsilon_{k},\epsilon_{l})=0}{Cov(\epsilon_k,\epsilon_l)=0}.

The number of strata/poststrata is given by \code{H}.
}
\value{
A vector of length six with the variance of the six sampling strategies.}
\references{
Bueno, E. (2018). \emph{A Comparison of Stratified Simple Random Sampling and Probability Proporional-to-size Sampling.} Research Report, Department of Statistics, Stockholm University 2018:6. \url{http://gauss.stat.su.se/rr/RR2018_6.pdf}.
}
\seealso{
\code{\link{expvar}} for the expected variance of five sampling strategies.
}
\examples{
f<- function(x,b0,b1,b2,...) {b0+b1*x^b2}
g<- function(x,b3,...) {x^b3}
x<- 1 + sort( rgamma(5000, shape=4/9, scale=108) )
y<- simulatey(x,f,g,dist="gamma",b0=10,b1=1,b2=1.25,b3=0.5,rho=0.90)

desvar(y,x,n=500,H=6,d2=1.25,d4=0.50)
desvar(y,x,n=500,H=6,d2=1.00,d4=1.00)
}
\keyword{survey}