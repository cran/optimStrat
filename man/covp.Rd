\name{covp}
\alias{covp}
\title{Covariance}
\description{Compute the covariance between \code{x} and \code{y}.}
\usage{
covp(x, y)
}
\arguments{
  \item{x}{a numeric vector.}
  \item{y}{a numeric vector.}
}
\details{
Compute the covariance between \code{x} and \code{y} using \eqn{n} (instead of \eqn{n-1} as in \code{\link{cov}}) in the denominator.

If the length of \code{x} and \code{y} are different, the elements of the shortest one will be recycled as necessary.
}
\value{
An object with the covariance between \code{x} and \code{y}.}
\seealso{
\code{\link{cov}}
}
\examples{
x<- rnorm(100)
y<- rnorm(100)
covp(x,y)
}
