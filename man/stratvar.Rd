\name{stratvar}
\alias{stratvar}
\title{Compute the Variance of Five Sample Strategies}
\description{Simulate the values of a study variable using the auxiliary variable \code{x} and then compute the design variance of five sample strategies: \eqn{\pi}ps--reg, STSI--reg, STSI--HT, \eqn{\pi}ps--pos and STSI--pos. The process is iterated \code{it} times.}
\usage{
stratvar(x, sk = 3, H, n, b0, b1, b2, b3, b4, d2 = b2, d4 = b4, it = 1)
}
\arguments{
  \item{x}{a positive integer or numeric vector. If an integer, indicates the desired size of the auxiliary variable to simulate. If a vector, gives the values of the auxiliary variable itself.}
  \item{sk}{if \code{x} is an integer, indicates the desired skewness of the auxiliary variable to simulate. Ignored otherwise.}
  \item{H}{a positive integer smaller or equal than \code{length(x)} giving the desired number of strata.}
  \item{n}{a positive integer giving the desired sample size.}
  \item{b0}{a number giving the intercept of the trend term in the superpopulation model.}
  \item{b1}{a number giving the scale of the trend term in the superpopulation model.}
  \item{b2}{a number giving the shape of the trend term in the superpopulation model.}
  \item{b3}{a nonnegative number giving the scale of the spread term in the superpopulation model.}
  \item{b4}{a number giving the shape of the spread term in the superpopulation model.}
  \item{d2}{a number giving the \emph{assumed} shape of the trend term in the superpopulation model.}
  \item{d4}{a number giving the \emph{assumed} shape of the spread term in the superpopulation model.}
  \item{it}{a positive integer indicating the number of times to iterate the process.}
}
\details{
If \code{x} is a positive integer, the values of an auxiliary variable are simulated as realizations from a gamma distribution with mean 48 and skewness equal to \code{sk}. If \code{x} is a vector, it is the auxiliary variable itself.

With this auxiliary information, values for the study variable \code{y} are simulated using the superpopulation model via \code{\link{simulatey}}.

The variance of a sample of size \code{n} is then computed for five sample strategies (\eqn{\pi}ps--reg, STSI--reg, STSI--HT, \eqn{\pi}ps--pos and STSI--pos) assuming that the right model has \eqn{\delta_2} instead of \eqn{\beta_2} and \eqn{\delta_4} instead of \eqn{\beta_4}.

The number of strata/poststrata is given by \code{H}.

The process is iterated \code{it} times.

}
\value{
A matrix of size \code{it} x 17. Each row being the results obtained for each iteration. The first eleven columns are the input parameters followed by the correlation between \code{x} and \code{y}. The last five columns give the variance of the five strategies under comparison.
}
%\references{}
\seealso{
\code{\link{simulatey}} for the simulation of the \code{y} values; \code{\link{stratify}} for how to define the strata/poststrata boundaries; \code{\link{optiallo}}
 for how the sample size is allocated into the strata.}
\examples{
#The assumed model coincides with the true generating model
stratvar(5000,sk = 3, H=5, n=100, b0=0, b1=1, b2=1, b3=0.05, b4=1, it=10)
    
#The assumed model differs with the true generating model
stratvar(5000,sk = 3, H=5, n=100, b0=0, b1=1, b2=1.5, b3=5e+04, 
   b4=0.5, d2 = 1, d4 = 1, it=10)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
