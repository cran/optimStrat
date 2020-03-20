\name{varp}
\alias{varp}
\title{Variance}
\description{Compute the variance of \code{x}.}
\usage{
varp(x)
}
\arguments{
  \item{x}{a numeric vector.}
}
\details{
Compute the variance of \code{x} using \eqn{n} (instead of \eqn{n-1} as in \code{\link{var}}) in the denominator.
}
\value{
An object with the variance of \code{x}.
}
\seealso{
\code{\link{var}}
}
\examples{
x<- rnorm(100)
varp(x)
var(x)
}
\keyword{internal}