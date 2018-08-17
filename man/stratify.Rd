\name{stratify}
\alias{stratify}
\title{Stratification of an Auxiliary Variable}
\description{Stratify the auxiliary variable \code{x} into \code{H} strata using the cum-sqrt-rule.}
\usage{
stratify(x, H, forced = FALSE, J = NULL)
}
\arguments{
  \item{x}{a positive numeric vector giving the values of the auxiliary variable.}
  \item{H}{a positive integer smaller or equal than \code{length(x)} giving the desired number of strata.}
  \item{forced}{a logical value indicating if the number of strata \emph{must} be exactly equal to \code{H} (see \sQuote{Details}).}
  \item{J}{a positive integer indicating the number of bins used for the cum-sqrt-rule.}
}
\details{
The cum-sqrt-rule is used in order to define \code{H} strata from the auxiliary vector \code{x}.

Note that if \code{length(x) < H} then \code{forced} will be set to \code{FALSE}.
}
\value{
A numeric vector giving the stratum to which each observation in \code{x} belongs.}
\references{
Sarndal, C.E., Swensson, B. and Wretman, J. (1992). \emph{Model Assisted Survey Sampling}. Springer.
}
\seealso{
\code{\link{optiallo}} for computing the variance of Stratified Simple Random Sample.
}
\examples{
x<- 1+sort(rgamma(100,shape=4/9,scale=108))
stratify(x,H=3)
}
\keyword{survey}