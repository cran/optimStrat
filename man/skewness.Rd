\name{skewness}
\alias{skewness}
\title{Sample Skewness}
\description{Calculate the sample skewness.}
\usage{
skewness(x, na.rm = FALSE)
}
\arguments{
  \item{x}{a numeric vector.}
  \item{na.rm}{a logical value indicating whether \code{NA} values should be stripped before the computation proceeds.}
}
\details{
Compute the sample skewness of \code{x} as
\deqn{\frac{\frac{1}{N}\sum_{i=1}^{N}\left(x_{i}-\bar{x}\right)^{3}}{\left[\frac{1}{N-1}\sum_{i=1}^{N}\left(x_{i}-\bar{x}\right)^{2}\right]^{3/2}}}{(1/N)(\Sigma (x_i - x_bar)^3) / (((1/N)\Sigma (x_i - x_bar)^2)^(3/2))}
}
\value{
A vector of length one giving the sample skewness of \code{x}.}
\examples{
x<- rnorm(1000)
skewness(x)
}
\keyword{univar}