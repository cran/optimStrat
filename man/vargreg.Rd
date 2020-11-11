\name{vargreg}
\alias{vargreg}
\title{
Design variance of the general regression estimator.
}
\description{
Compute the (approximated) design variance of the general regression estimator of the total of a study variable under different sampling designs.
}
\usage{
vargreg(formula, design = NULL, n, stratum = NULL, 
        x_des = NULL, inc.p = NULL, ...)
}
\arguments{
  \item{formula}{an object of class \code{\link{formula}}: a symbolic description of the model to be fitted. The details of model specification are given under \sQuote{Details}.}
  \item{design}{a character string giving the sampling design. It must be one of 'srs' (simple random sampling without replacement),  'poi' (Poisson sampling), 'stsi' (stratified simple random sampling), 'pips' (Pareto \eqn{\pi}ps sampling) or \code{NULL} (see \sQuote{Details}).}
  \item{n}{either a positive number indicating the (expected) sample size (when \code{design} is one of 'srs', 'poi', 'pips' or \code{NULL}) or a numeric vector indicating the sample size of the strata to which each element belongs (when \code{design} is 'stsi') (see \sQuote{Examples}).}
  \item{stratum}{a vector indicating the stratum to which every unit belongs. Only used if \code{design} is 'stsi'.}
  \item{x_des}{a positive numeric vector giving the values of the auxiliary variable that is used for defining the inclusion probabilities. Only used if \code{design} is 'poi' or 'pips'.}
  \item{inc.p}{a matrix giving the first and second order inclusion probabilities. Only used if \code{design} is \code{NULL}.}
  \item{\dots}{other arguments passed to \code{\link{lm}} (see \sQuote{Details}).}
}
\details{
The \code{formula} should be of the form \code{y~x}, where \code{y} is the study variable and \code{x} are the auxiliary variables used by the general regression (GREG) estimator, \eqn{\hat{t}}{t_hat},. See \code{\link{formula}} for more details and \sQuote{Examples} for typical expressions for some well-known estimators (e.g. the Horvitz-Thompson, ratio, regression and poststratification estimators).

The variance of the GREG estimator is approximated by
\deqn{AV\left(\hat{t}\right) = \sum_{k=1}^{N}\sum_{l=1}^{N}\pi_{kl}\frac{E_{k}}{\pi_{k}}\frac{E_{l}}{\pi_{l}} - \left(\sum_{k=1}^{N}E_{k}\right)^{2}}{AV(t_hat) = \Sigma_[k=1]^N \Sigma_[l=1]^N \pi_kl (E_k*E_l)/(\pi_k*\pi_l) - (\Sigma_[k=1]^N E_k)^2}
where
\deqn{E_{k} = y_{k}-\hat{y}_{k} \textrm{ and } \hat{y}_{k} = x_{k}B \textrm{ with } B = \left(\sum_{k=1}^{N}w_{k}x_{k}^{'}x_{k}\right)\sum_{k=1}^{N}w_{k}x_{k}^{'}y_{k}}{E_k = y_k - y*_k  and y*_k = x_kB  with  B = (\Sigma_[k=1]^N w_k*x'_k*x_k) \Sigma_[k=1]^N w_k*x'_k*y_k}

\eqn{N} is the population size and \eqn{\pi_{k}}{\pi_k} and \eqn{\pi_{kl}}{\pi_kl} are, respectively, the first and second order inclusion probabilities. \eqn{w_{k}}{w_k} is a weight associated to each element and it represents the inverse of the conditional variance (up to a scalar) of the underlying superpopulation model (see \sQuote{Examples}).

If \code{design=NULL}, the matrix of inclusion probabilities is obtained proportional to the matrix \code{p.inc}. If \code{design} is other than \code{NULL}, the formula for the variance is simplified in such a way that the inclusion probabilities matrix is no longer necessary. In particular:
\itemize{
\item if \code{design='srs'}, only the sample size \code{n} is required;
\item if \code{design='stsi'}, both the stratum ID \code{stratum} and the sample size per stratum \code{n}, are required;
\item if \code{design} is either \code{'pips'} or \code{'poi'}, the inclusion probabilities are obtained proportional to the values of \code{x_des}, corrected if necessary.
}
}

\value{A numeric value giving the variance of the general regression estimator under the desired design.}

\seealso{
\code{\link{desvar}} for the simultaneous calculation of the variance of six sampling strategies; \code{\link{expgreg}} for the expected variance of the GREG estimator under a superpopulation model; \code{\link{expvar}} for the simultaneous calculation of the expected variance of five sampling strategies under a superpopulation model; \code{\link{optimApp}} for an interactive application of \code{expgreg}.
}

\references{
Sarndal, C.E., Swensson, B. and Wretman, J. (1992). \emph{Model Assisted Survey Sampling}. Springer.

Rosen, B. (1997). \emph{On Sampling with Probability Proportional to Size.} Journal of Statistical Planning and Inference \strong{62}, 159-191.
}
\examples{
f<- function(x,b0,b1,b2,...) {b0+b1*x^b2}
g<- function(x,b3,...) {x^b3}
x<- 1 + sort( rgamma(5000, shape=4/9, scale=108) )
y<- simulatey(x,f,g,dist="gamma",b0=10,b1=1,b2=1,b3=1,rho=0.95)

st1<- optiallo(n=100,x=x,H=6)
vargreg("y~0",design="srs",n=100)                         #SRS-HT
vargreg("y~0",design="poi",n=100,x_des=x)                 #Poi-HT
vargreg("y~0",design="stsi",n=st1$nh,stratum=st1$stratum) #STSI-HT
vargreg("y~0",design="pips",n=100,x_des=x)                #PIPS-HT

vargreg("y~x-1",design="srs",n=100,weights=1/x)          #SRS-ratio
vargreg("y~x-1",design="poi",n=100,x_des=x,weights=1/x)  #Poi-ratio
vargreg("y~x-1",design="stsi",n=st1$nh,
        stratum=st1$stratum,weights=1/x)                 #STSI-ratio
vargreg("y~x-1",design="pips",n=100,x_des=x,weights=1/x) #PIPS-ratio

vargreg("y~x",design="srs",n=100)                         #SRS-reg
vargreg("y~x",design="poi",n=100,x_des=x)                 #Poi-reg
vargreg("y~x",design="stsi",n=st1$nh,stratum=st1$stratum) #STSI-reg
vargreg("y~x",design="pips",n=100,x_des=x)                #PIPS-reg

x2<- as.factor(st1$stratum)
vargreg("y~x2",design="srs",n=100)                          #SRS-pos
vargreg("y~x2",design="poi",n=100,x_des=x)                  #Poi-pos
vargreg("y~x2",design="stsi",n=st1$nh,stratum=st1$stratum)  #STSI-pos
vargreg("y~x2",design="pips",n=100,x_des=x)                 #PIPS-pos

y2<- c(16,21,18)
x2<- y2
inc.probs<- matrix(c(8,5,4,5,7,3,4,3,6),3,3)
vargreg("y2~0",n=2.1,inc.p=inc.probs)                 #HT
vargreg("y2~x2-1",n=2.1,inc.p=inc.probs,weights=1/x2) #Ratio
vargreg("y2~x2",n=2.1,inc.p=inc.probs)                #Regression
x3<- as.factor(c(1,2,2))
vargreg("y2~x3",n=2.1,inc.p=inc.probs)                #Post.
}

\keyword{survey}
