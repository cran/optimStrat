\name{gk}
\alias{gk}
\title{Computes the gk}
\description{
Compute the values of the function gk.
}
\usage{
gk(x, Beta21, Beta22)
}
\arguments{
  \item{x}{a matrix or data.frame giving the values of the auxiliary variables.}
  \item{Beta21}{a numeric vector of length equal to the number of variables in \code{x} giving the coefficients of the spread term in the \emph{true} superpopulation model (see \sQuote{Details}).}
  \item{Beta22}{a numeric vector of length equal to the number of variables in \code{x} giving the exponents of the spread term in the \emph{true} superpopulation model (see \sQuote{Details}).}
}
\details{
Compute the values of
\deqn{g(x_{k}|\beta) = \sum_{j=1}^{J}\beta_{2,j}x_{jk}^{\beta_{2,J+j}}}{g(x_k|\beta) = \Sigma_j=1^J \beta_2,j x_jk^\beta_2,J+j}

The coefficients \eqn{\beta_{2,j}}{\beta_2,j} (\eqn{j=1,\cdots,J}) are given by \code{Beta21}. The exponents \eqn{\beta_{2,j}}{\beta_2,j} (\eqn{j=J+1,\cdots,2J}) are given by \code{Beta22}.
}
\value{
A numeric vector giving the values of the function.}
%\references{
%% ~put references to the literature/web site here ~
%}
%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
x1<- 1 + sort( rgamma(30, shape=4/9, scale=108) )
x2<- 1 + sort( rgamma(30, shape=4/9, scale=108) )
x3<- 1 + sort( rgamma(30, shape=4/9, scale=108) )
x<- cbind(x1,x2,x3)
gk(x,Beta21=c(1,2,-1),Beta22=c(1,0.75,0.5))
}
\keyword{survey}
