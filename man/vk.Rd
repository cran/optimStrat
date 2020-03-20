\name{vk}
\alias{vk}
\title{
Calculate the values of the function f.
}
\description{
Calculate the values of the function f under both the true and the misspecified model.
}
\usage{
vk(x, Beta11, Beta12, Delta12, ak = 1)
}
\arguments{
  \item{x}{a matrix or data.frame giving the values of the auxiliary variables.}
  \item{Beta11}{a numeric vector of length equal to the number of variables in \code{x} giving the coefficients of the trend term in the \emph{true} superpopulation model (see \sQuote{Details}).}
  \item{Beta12}{a numeric vector of length equal to the number of variables in \code{x} giving the exponents of the trend term in the \emph{true} superpopulation model (see \sQuote{Details}).}
  \item{Delta12}{a numeric vector of length equal to the number of variables in \code{x} giving the exponents of the trend term in the \emph{assumed} superpopulation model (see \sQuote{Details}).}
  \item{ak}{a vector of weights.}
}
\details{
Compute the values of
\deqn{f(x_{k}|\beta) = \sum_{j=1}^{J}\beta_{1,j}x_{jk}^{\beta_{1,J+j}}}{f(x_k|\beta) = \Sigma_j=1^J \beta_1,j x_jk^\beta_1,J+j}
and
\deqn{f(x_{k}|\delta) = \sum_{j=1}^{J}\hat{\delta}_{1,j}x_{jk}^{\delta_{1,J+j}}}{f(x_k|\delta) = \Sigma_j=1^J \delta_hat_1,j x_jk^\delta_1,J+j}
where  \eqn{\hat{\delta}_{1}=A\beta_{1}}{\delta_hat_1 = A \beta_1} and
\deqn{A = \left(\sum_{U}\frac{x^{\delta_{12'}}_{k}x^{\delta_{12}}_{k}}{a_{k}}\right)\sum_{U}\frac{x_{k}^{\delta_{12'}}x_{k}^{\beta_{12'}}}{a_{k}}}{A = (\Sigma_U x^\delta_12'_k * x^\delta_12_k/a_k) / Sigma_U x_k^\delta_12'_k * x_k^\beta_12_k / a_k}.

The coefficients \eqn{\beta_{1,j}}{\beta_1,j} (\eqn{j=1,\cdots,J}) are given by \code{Beta11}. The exponents \eqn{\beta_{1,j}}{\beta_1,j} (\eqn{j=J+1,\cdots,2J}) are given by \code{Beta12}. The exponents \eqn{\delta_{1,j}}{\delta_1,j} (\eqn{j=J+1,\cdots,2J}) are given by \code{Delta12}.
}
\value{A list with two components
\item{fbk}{a vector giving the values of the function f under the true model}
\item{fdk}{a vector giving the values of the function f under the misspecified model}
}
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
vk(x,Beta11=c(1,2,-1),Beta12=c(1,0.75,0.5),Delta12=c(1,1,1))
}
\keyword{survey}
