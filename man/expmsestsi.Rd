\name{expmsestsi}
\alias{expmsestsi}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Anticipated Mean Squared Error of a STSI design}
\description{
Compute the anticipated Mean Squared Error of a Stratified Simple Random Sampling design.
}
\usage{
expmsestsi(x, stratum, nh, Beta11, Beta12, Beta21, Beta22, Delta12, Rfy, ak = 1)
}
\arguments{
  \item{x}{a matrix or data.frame giving the values of the auxiliary variables.}
  \item{stratum}{a vector indicating the stratum to which each element belongs.}
  \item{nh}{a vector indicating the sample size of the stratum to which each element belongs.}
  \item{Beta11}{a numeric vector of length equal to the number of variables in \code{x} giving the coefficients of the trend term in the \emph{true} superpopulation model (see \sQuote{Details}).}
  \item{Beta12}{a numeric vector of length equal to the number of variables in \code{x} giving the exponents of the trend term in the \emph{true} superpopulation model (see \sQuote{Details}).}
  \item{Beta21}{a numeric vector of length equal to the number of variables in \code{x} giving the coefficients of the spread term in the \emph{true} superpopulation model (see \sQuote{Details}).}
  \item{Beta22}{a numeric vector of length equal to the number of variables in \code{x} giving the exponents of the spread term in the \emph{true} superpopulation model (see \sQuote{Details}).}
  \item{Delta12}{a numeric vector of length equal to the number of variables in \code{x} giving the exponents of the trend term in the \emph{assumed} superpopulation model (see \sQuote{Details}).}
  \item{Rfy}{a number giving the square root of the coefficient of determination between the auxiliary variables and the study varible.}
  \item{ak}{a vector of weights.}
}
\details{
The Anticipated Mean Squared Error of the strategy that couples a STSI design with the general regression estimator is computed.

It is assumed that the underlying superpopulation model is of the form
\deqn{Y_{k} = \sum_{j=1}^{J}\delta_{1,j}x_{jk}^{\delta_{1,J+j}} + \epsilon_{k}}{Y_k = \Sigma_{j=1}^J \delta_{1,j} x_jk^\delta_{1,J+j} + \epsilon_k}
with \eqn{E\epsilon_{k}=0}{E\epsilon_k=0}, \eqn{V\epsilon_{k}=\sigma^{2}\sum_{j=1}^{J}\delta_{2,j}x_{jk}^{\delta_{2,J+j}}}{V\epsilon_k = \sigma^2 \Sigma_j=1^J \delta_2,j x_jk^\delta_2,J+j} and \eqn{Cov(\epsilon_{k},\epsilon_{l})=0}{Cov(\epsilon_k,\epsilon_l)=0}.

But the true generating model is of the form
\deqn{Y_{k} = \sum_{j=1}^{J}\beta_{1,j}x_{jk}^{\beta_{1,J+j}} + \epsilon_{k}}{Y_k = \Sigma_{j=1}^J \beta_{1,j} x_jk^\beta_{1,J+j} + \epsilon_k}
with \eqn{E\epsilon_{k}=0}{E\epsilon_k=0}, \eqn{V\epsilon_{k}=\sigma^{2}\sum_{j=1}^{J}\beta_{2,j}x_{jk}^{\beta_{2,J+j}}}{V\epsilon_k = \sigma^2 \Sigma_j=1^J \beta_2,j x_jk^\beta_2,J+j} and \eqn{Cov(\epsilon_{k},\epsilon_{l})=0}{Cov(\epsilon_k,\epsilon_l)=0}.

The coefficients \eqn{\beta_{1,j}}{\beta_1,j} (\eqn{j=1,\cdots,J}{j=1,...,J}) are given by \code{Beta11}. The exponents \eqn{\beta_{1,j}}{\beta_1,j} (\eqn{j=J+1,\cdots,2J}{j=J+1,...,2J}) are given by \code{Beta12}. The coefficients \eqn{\beta_{2,j}}{\beta_2,j} (\eqn{j=1,\cdots,J}{j=1,...,J}) are given by \code{Beta21}. The exponents \eqn{\beta_{2,j}}{\beta_2,j} (\eqn{j=J+1,\cdots,2J}{j=J+1,...,2J}) are given by \code{Beta22}.

The exponents \eqn{\delta_{1,j}}{\delta_1,j} (\eqn{j=J+1,\cdots,2J}{j=J+1,...,2J}) are given by \code{Delta12}.
}
\value{A numeric value giving the anticipated Mean Squared Error.}
\references{
Bueno, E. (2018). \emph{A Comparison of Stratified Simple Random Sampling and Probability Proporional-to-size Sampling.} Research Report, Department of Statistics, Stockholm University 2018:6. \url{http://gauss.stat.su.se/rr/RR2018_6.pdf}.
}
%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
x1<- 1 + sort( rgamma(5000, shape=4/9, scale=108) )
x2<- 1 + sort( rgamma(5000, shape=4/9, scale=108) )
x3<- 1 + sort( rgamma(5000, shape=4/9, scale=108) )
x<- cbind(x1,x2,x3)
stratum1<- optiallo(n=150,x=x3,H=6)
expmsestsi(x,stratum1$stratum,stratum1$nh,Beta11=c(1,-1,0),Beta12=c(1,1,0),
   Beta21=c(0,0,1),Beta22=c(0,0,0.5),Delta12=c(1,1,0),Rfy=0.8)
expmsestsi(x,stratum1$stratum,stratum1$nh,Beta11=c(1,-1,0),Beta12=c(1,1,0),
   Beta21=c(0,0,1),Beta22=c(0,0,0.5),Delta12=c(1,0,1),Rfy=0.8)
}
\keyword{survey}