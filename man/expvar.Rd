\name{expvar}
\alias{expvar}
\title{Expected variance}
\description{Compute the expected variance of five sampling strategies.}
\usage{
expvar(b, d, x, n, H, Rxy, stratum1 = NULL, stratum2 = NULL, st = 1:5,
   short = FALSE)
}
\arguments{
  \item{b}{a numeric vector of length two giving the \emph{true} shapes of the 
trend and spread terms.}
  \item{d}{a numeric vector of length two giving the \emph{assumed} shapes of the 
trend and spread terms.}
  \item{x}{a positive numeric vector giving the values of the auxiliary variable.}
  \item{n}{a positive integer indicating the desired sample size.}
  \item{H}{a positive integer giving the 
desired number of strata/poststrata. Ignored if \code{stratum1} and \code{stratum2} 
are given.}
  \item{Rxy}{a number giving the correlation between the auxiliary variable and 
the study variable.}
  \item{stratum1}{a list giving stratum and sample sizes per stratum 
(see \sQuote{Details}).}
  \item{stratum2}{a list giving stratum and sample sizes per stratum (see 
\sQuote{Details}).}
  \item{st}{a numeric vector indicating the strategies for which the expected variance is to be calculated (see \sQuote{Details}).}
  \item{short}{logical. If \code{FALSE} (the default) a vector of length five is 
returned. If \code{TRUE} only the strategies given by \code{st} are returned.}
}
\details{
The expected variance of a sample of size \code{n} is computed for 
five sampling strategies (\eqn{\pi}ps--reg, STSI--reg, STSI--HT, \eqn{\pi}ps--pos and STSI--pos).

The strategies are defined assuming that the underlying superpopulation model is of the form
\deqn{Y_{k}=\delta_{0}+\delta_{1}x_{k}^{\delta_{2}}+\epsilon_{k}}{Y_k = \delta_0 + \delta_1 x_k^\delta_2 + \epsilon_k}
with \eqn{E\epsilon_{k}=0}{E\epsilon_k = 0}, \eqn{V\epsilon_{k}=\delta_{3}^{2}x_{k}^{2\delta_{4}}}{V\epsilon_k = \delta_3^2 x_k^2\delta_4} and \eqn{Cov(\epsilon_{k} , \epsilon_{l}) = 0}{Cov(\epsilon_k , \epsilon_l) = 0}. But the true generating model is of the form
\deqn{Y_{k}=\beta_{0}+\beta_{1}x_{k}^{\beta_{2}}+\epsilon_{k}}{Y_k = \beta_0 + \beta_1 x_k^\beta_2 + \epsilon_k}
with \eqn{E\epsilon_{k}=0}{E\epsilon_k = 0}, \eqn{V\epsilon_{k} = \beta_{3}^{2}x_{k}^{2\beta_{4}}}{V\epsilon_k = \beta_3^2 x_k^2\beta_4} and \eqn{Cov(\epsilon_{k},\epsilon_{l})=0}{Cov(\epsilon_k , \epsilon_l) = 0}.

The parameters \eqn{\beta_2} and \eqn{\beta_4} are given by \code{b}. The parameters \eqn{\delta_2} and \eqn{\delta_4} are given by \code{d}.

\code{stratum1} and \code{stratum2} are lists with two components (each with length \code{length(x)}): \code{stratum} indicates the stratum to which each element belongs and \code{nh} indicates the sample sizes to be selected in each stratum. They can be created via \code{\link{optiallo}}. \code{stratum1} gives the stratification for STSI--HT and the poststrata for \eqn{\pi}ps--pos and STSI--pos; whereas \code{stratum2} gives the stratification for STSI--reg and STSI--pos. If \code{NULL}, \code{\link{optiallo}} is used for defining \code{H} strata/poststrata.

\code{st} indicates which variances to be calculated. If \code{1 in st}, the expected variance of \eqn{\pi}ps--reg is calculated. If \code{2 in st}, the expected variance of STSI--reg is calculated, and so on.
}
\value{If \code{short=FALSE} a vector of length five is returned giving the expected variance of the strategies given in \code{st}. \code{NA} is returned for those strategies not given in \code{st}. If \code{short=TRUE}, the \code{NA}s are omitted.}
\references{
Bueno, E. (2018). \emph{A Comparison of Stratified Simple Random Sampling and Probability Proportional-to-size Sampling.} Research Report, Department of Statistics, Stockholm University 2018:6. \url{http://gauss.stat.su.se/rr/RR2018_6.pdf}.
}
\seealso{
\code{\link{optiallo}} for how to stratify an auxiliary variable and allocate the sample size; \code{\link{desvar}} for calculating the variance of the five strategies.
}
\examples{
x<- 1 + sort( rgamma(5000, shape=4/9, scale=108) )
expvar(b=c(1,1),d=c(1,1),x,n=500,H=6,Rxy=0.9)
expvar(b=c(1,1),d=c(1,1),x,n=500,H=6,Rxy=0.9,st=1:3)
expvar(b=c(1,1),d=c(1,1),x,n=500,H=6,Rxy=0.9,st=1:3,short=TRUE)

st1<- optiallo(n=500,x,H=6)
post1<- optiallo(n=500,x^1.5,H=10)
expvar(b=c(1,1),d=c(1,1),x,n=500,H=6,Rxy=0.9,
   stratum1=post1,stratum2=st1)
}
\keyword{survey}