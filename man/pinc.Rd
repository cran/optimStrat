\name{pinc}
\alias{pinc}
\title{
Inclusion probabilities in a PIps design
}
\description{
Compute the inclusion probabilities to be used in a PIps design with sample size equal to \code{n}.
}
\usage{
pinc(n, x)
}
\arguments{
  \item{n}{a positive integer indicating the desired sample size.}
  \item{x}{a positive numeric vector giving the values of the auxiliary variable.}
}
\details{
The inclusion probabilities are calculated as \eqn{n\times x_{k}/t_{x}}{n x_k / t_x} and corrected, if necessary, to ensure that they are smaller or equal than one.
}
\value{A numeric vector giving the inclusion probability of each element.}
\examples{
x<- 1 + sort( rgamma(100, shape=4/9, scale=108) )
pinc(n=30,x)
}
\keyword{survey}
