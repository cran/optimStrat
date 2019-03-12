\name{optiallo}
\alias{optiallo}
\title{Optimal allocation in stratified simple random sampling}
\description{
Allocates a sample of size \code{n} using Neyman optimal allocation in Stratified Simple Random Sampling.}
\usage{
optiallo(n, x, stratum = NULL, ...)
}
\arguments{
  \item{n}{a positive integer indicating the desired sample size.}
  \item{x}{a positive numeric vector giving the values of the auxiliary variable.}
  \item{stratum}{a vector indicating the stratum to which every unit belongs (see \sQuote{Details}).}
  \item{\dots}{other arguments passed to \code{\link{stratify}} (see \sQuote{Details}).}
}
\details{
Allocates a sample of size \code{n} using Neyman optimal allocation in Stratified Simple Random Sampling.

If \code{stratum==NULL}, the stratification is generated via \code{\link{stratify}}. Then at least the number of strata should be passed to \code{\link{stratify}} using the argument \code{H}.
}
\value{
A list with two elements:
\item{stratum}{a vector indicating the stratum to which each element belongs.}
\item{nh}{a vector indicating the sample size of the strata to which each element belongs.}
}
%\references{
%Bueno, E. (2018). \emph{A Comparison of Stratified Simple Random Sampling and Probability Proporional-to-size Sampling.} Research Report, Department of Statistics, Stockholm University 2018:6. \url{http://gauss.stat.su.se/rr/RR2018_6.pdf}.
%}
\seealso{
\code{\link{stratify}} for defining the stratification using the cum-sqrt-rule.
}
\examples{
x<- 1 + sort( rgamma(100, shape=4/9, scale=108) )
st1<- stratify(x,H=6)
optiallo(n=30,x,stratum=st1)

optiallo(n=30,x,H=6)
}
\keyword{survey}
