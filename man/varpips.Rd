\name{varpips}
\alias{varpips}
\title{Variance of Pareto PIps Sampling with the HT Estimator}
\description{Compute the design variance of the Horvitz-Thompson estimator of the total of \code{y} under Pareto probability proportional-to-size Sampling, where the size variable is indicated by \code{x} and the sample size is \code{n}.}
\usage{
varpips(n, x, y)
}
\arguments{
  \item{n}{a positive integer indicating the desired sample size.}
  \item{x}{a positive numeric vector giving the values of the auxiliary variable that is used in order to define the desired inclusion probabilities.}
  \item{y}{a numeric vector giving the values of the study variable.}
  }
\details{
Target inclusion probabilities are computed as \eqn{\pi_{k} = n\cdot x_{k}/\sum x_{k}}{\pi_k = n x_k / sum(x_k)}.

If \eqn{\pi_{k}>1}{\pi_k > 1} for at least one element, \eqn{\pi_k} is set equal to one for those elements and the inclusion probabilities are calculated again for the remaining elements with the remaining sample size.

Once the \eqn{\pi_k} are obtained, the variance of the Horvitz-Thompson estimator under Pareto probability proportional-to-size Sampling is computed as: \eqn{V_{\pi ps}\left[\hat{t}_{HT}\right] = \frac{N}{N-1}(t_{1}-\frac{t_{2}^{2}}{t_{3}})}{V_\pips [t_HT] = N/(N-1) (t_1 - (t_2^2)/t_3)} with
\deqn{t_{1} = \sum\frac{y_{k}^{2}(1-\pi_{k})}{\pi_{k}}}{t_1 = \Sigma y_k (1-\pi_k)/\pi_k}
\deqn{t_{2} = \sum y_{k}(1-\pi_{k})}{t_2 = \Sigma y_k (1-\pi_k)}
\deqn{t_{3} = \sum \pi_{k}(1-\pi_{k})}{t_3 = \Sigma \pi_k (1-\pi_k)}
}
\value{
A list containing the following:
\item{variance}{a vector of length one giving the variance of the Horvitz-Thompson estimator under Pareto probability proportional-to-size Sampling.}
\item{pinc}{a vector with length \code{length(x)} giving the target inclusion probabilities of each element..}
}
\references{
Rosen, B. (1997). \emph{On Sampling with Probability Proportional to Size.} Journal of Statistical Planning and Inference \strong{62}, 159-191.
}
\examples{
x<- 1 + sort( rgamma(5000, shape=4/9, scale=108) ) #simulating the auxiliary variable
y<- rgamma(x, shape=1, scale=x) #simulating the study variable
z<- varpips(n=500, x=x, y=y)
z$variance
}
\keyword{survey}
