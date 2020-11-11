\name{simulatey}
\alias{simulatey}
\title{Simulate the Study Variable}
\description{Simulate values for the study variable based on the auxiliary variable \code{x} and an assumed superpopulation model.}
\usage{
simulatey(x, f, g, dist = "normal", rho = NULL, Sigma = NULL, ...)
}
\arguments{
  \item{x}{a numeric vector giving the values of the auxiliary variable.}
  \item{f}{the name of the function defining the desired trend (see \sQuote{Details}).}
  \item{g}{the name of the function defining the desired spread (see \sQuote{Details}).}
  \item{dist}{the desired distribution of the study variable conditioned on the auxiliary variable. Either 'normal' or 'gamma' (see \sQuote{Details}).}
  \item{rho}{a number giving the absolute value of the desired correlation between \code{x} and the vector to be simulated.}
  \item{Sigma}{a nonnegative number giving the scale of the spread term in the superpopulation model. Ignored if \code{rho} is given (see \sQuote{Details}).}
  \item{\dots}{other arguments passed to \code{f} and \code{g} (see \sQuote{Details}).}
}
\details{
The values of the study variable \code{y} are simulated using a superpopulation model defined as:
\deqn{Y_{k}=f(x_{k})+\epsilon_{k}}{Y_k = f(x_k) + \epsilon_k}
with \eqn{E(\epsilon_{k}) = 0}{E(\epsilon_k) = 0}, \eqn{V(\epsilon_{k}) = \sigma^{2}g^{2}(x_{k})}{V(\epsilon_k) = \sigma^2 g^2(x_k)} and \eqn{Cov(\epsilon_{k},\epsilon_{l}) = 0}{V(\epsilon_k,\epsilon_l) = 0} if \eqn{k\ne l}{k != l}. Also \eqn{Y_{k}|f(x_{k})}{Y_k|f(x_k)} is distributed according to \code{dist}.

\code{f} and \code{g} should return a vector of the same length of \code{x}. Their first argument should be \code{x} and they should not share the name of any other argument. Both \code{f} and \code{g} should have the \dots argument (see \sQuote{Examples}).

Note that \code{Sigma} defines the degree of association between \code{x} and \code{y}: the larger \code{Sigma}, the smaller the correlation, \code{rho}, and vice versa. For this reason only one of them should be defined. If both are defined, \code{Sigma} will be ignored.

Depending on the trend function \code{f}, some correlations cannot be reached. In those cases, \code{Sigma} will automatically be set to zero, \code{dist} will automatically be set to 'normal' and \code{rho} will be ignored (see \sQuote{Examples}).

If the trend term takes negative values, \code{dist} will be automatically set to 'normal'.
}
\value{
A numeric vector giving the simulated value of \code{y} associated to each value in \code{x}.
}
%\references{}
\examples{
f<- function(x,b0,b1,b2,...) {b0+b1*x^b2}
g<- function(x,b3,...) {x^b3}

x<- 1 + sort( rgamma(5000, shape=4/9, scale=108) )

#Linear trend and homocedasticity
y1<- simulatey(x,f,g,dist="normal",b0=0,b1=1,b2=1,b3=0,rho=0.90)
y2<- simulatey(x,f,g,dist="gamma",b0=0,b1=1,b2=1,b3=0,rho=0.90)

#Linear trend and heterocedasticity
y3<- simulatey(x,f,g,dist="normal",b0=0,b1=1,b2=1,b3=1,rho=0.90)
y4<- simulatey(x,f,g,dist="gamma",b0=0,b1=1,b2=1,b3=1,rho=0.90)

#Quadratic trend and homocedasticity
y5<- simulatey(x,f,g,dist="gamma",b0=0,b1=1,b2=2,b3=0,rho=0.80)

#Correlation of minus one
y6<- simulatey(x,f,g,dist="normal",b0=0,b1=-1,b2=1,b3=0,rho=1)

#Desired correlation cannot be attained
y7<- simulatey(x,f,g,dist="normal",b0=0,b1=1,b2=3,b3=0,rho=0.99)

#Negative expectation not possible under gamma distribution
y8<- simulatey(x,f,g,dist="gamma",b0=0,b1=-1,b2=1,b3=0,rho=1) 

#Conditional variance of zero not possible under gamma distribution
y9<- simulatey(x,f,g,dist="gamma",b0=0,b1=1,b2=3,b3=0,rho=0.99)
}
\keyword{survey}
