\name{desmse}
\alias{desmse}
\title{Design Mean Squared Error}
\description{Compute the design Mean Squared Error of five sampling strategies.}
\usage{
desmse(y, x, n, H, d2, d4)
}
\arguments{
  \item{y}{a numeric vector giving the values of the study variable.}
  \item{x}{a positive numeric vector giving the values of the auxiliary variable.}
  \item{n}{a positive integer indicating the desired sample size.}
  \item{H}{a positive integer smaller or equal than \code{length(x)} giving the desired number of strata/poststrata.}
  \item{d2}{a number giving the \emph{assumed} shape of the trend term in the superpopulation model.}
  \item{d4}{a number giving the \emph{assumed} shape of the spread term in the superpopulation model.}
}
\details{
The design Mean Squared Error of a sample of size \code{n} is computed for five sampling strategies (\eqn{\pi}ps--reg, STSI--reg, STSI--HT, \eqn{\pi}ps--pos and STSI--pos). The strategies are defined assuming that there is an underlying superpopulation model of the form
\deqn{Y_{k}=\delta_{0}+\delta_{1}x_{k}^{\delta_{2}}+\epsilon_{k}}{Y_k = \delta_0 + \delta_1 x_k^\delta_2 + \epsilon_k}
with \eqn{E\epsilon_{k}=0}{E\epsilon_k=0}, \eqn{V\epsilon_{k}=\delta_{3}^{2}x_{k}^{2\delta_{4}}}{V\epsilon_k=\delta_3^2 x_k^2\delta_4} and \eqn{Cov(\epsilon_{k},\epsilon_{l})=0}{Cov(\epsilon_k,\epsilon_l)=0}.

The number of strata/poststrata is given by \code{H}.
}
\value{
A vector of length five with the Mean Squared Error of the five sample strategies in the following order: \eqn{\pi}ps--reg, STSI--reg, STSI--HT, \eqn{\pi}ps--pos and STSI--pos.}
\references{
Bueno, E. (2018). \emph{A Comparison of Stratified Simple Random Sampling and Probability Proporional-to-size Sampling.} Research Report, Department of Statistics, Stockholm University 2018:6. \url{http://gauss.stat.su.se/rr/RR2018_6.pdf}.
}
\seealso{
\code{\link{expmse}} for the anticipated MSE of the five strategies.
}
\examples{
x<- 1 + sort( rgamma(5000, shape=4/9, scale=108) )
y<- simulatey(x, b0=0, b1=1, b2=1.25, b4=0.5, rho=0.90)
desmse(y,x,n=500,H=6,d2=1.25,d4=0.50)
desmse(y,x,n=500,H=6,d2=1.00,d4=1.00)
}
\keyword{survey}

