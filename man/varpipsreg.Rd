\name{varpipsreg}
\alias{varpipsreg}
\title{
Design variance of a PIps--reg sampling strategy.
}
\description{
Compute the design variance of the regression estimator of the total of \code{y} under Pareto probability proportional-to-size Sampling, where the size variable is indicated by \code{x_des} and the sample size is \code{n}.
}
\usage{
varpipsreg(y, x_des, n, x_est)
}
\arguments{
  \item{y}{a numeric vector giving the values of the study variable.}
  \item{x_des}{a positive numeric vector giving the values of the auxiliary variable that is used for defining the inclusion probabilities.}
  \item{n}{a positive integer indicating the desired sample size.}
  \item{x_est}{a positive numeric vector giving the values of the auxiliary variable that is used at the estimation stage.}
}
\details{
Target inclusion probabilities are computed as \eqn{\pi_{k} = n\cdot x_{k}/\sum x_{k}}{\pi_k = n x_k / sum(x_k)}.

If \eqn{\pi_{k}>1}{\pi_k > 1} for at least one element, \eqn{\pi_k} is set equal to one for those elements and the inclusion probabilities are calculated again for the remaining elements with the remaining sample size.

Once the \eqn{\pi_k} are obtained, the variance of the poststratified estimator under Pareto probability proportional-to-size Sampling is computed as: \eqn{V_{\pi ps}\left[\hat{t}_{HT}\right] = \frac{N}{N-1}(t_{1}-\frac{t_{2}^{2}}{t_{3}})}{V_\pips [t_HT] = N/(N-1) (t_1 - (t_2^2)/t_3)} with
\deqn{t_{1} = \sum\frac{E_{k}^{2}(1-\pi_{k})}{\pi_{k}}}{t_1 = \Sigma E_k (1-\pi_k)/\pi_k}
\deqn{t_{2} = \sum E_{k}(1-\pi_{k})}{t_2 = \Sigma E_k (1-\pi_k)}
\deqn{t_{3} = \sum \pi_{k}(1-\pi_{k})}{t_3 = \Sigma \pi_k (1-\pi_k)}
with \eqn{E_{k}=y_{k}-\hat{y}_{k}}{E_k = y_k - yhat_k}.
}
\value{A numeric value giving the variance of the regression estimator under Pareto probability proportional-to-size Sampling.}
\seealso{
\code{\link{varpips}} for the variance of the Horvitz-Thompson estimator under probability proportional-to-size sampling; \code{\link{varstsi}} for the variance of the Horvitz-Thompson estimator under stratified simple random sampling; \code{\link{varpipspos}} for the variance of the poststratified estimator under probability proportional-to-size sampling; \code{\link{varstsipos}} for the variance of the poststratified estimator under stratified simple random sampling; \code{\link{varstsireg}} for the variance of the regression estimator under stratified simple random sampling.
}
\references{
Rosen, B. (1997). \emph{On Sampling with Probability Proportional to Size.} Journal of Statistical Planning and Inference \strong{62}, 159-191.
}
\examples{
x<- 1 + sort( rgamma(5000, shape=4/9, scale=108) ) #simulating the auxiliary variable
y<- simulatey(x,b0=10,b1=1,b2=1.25,b4=0.75,rho=0.95)
varpipsreg(y, x_des=x^0.75, n=500, x_est=x^1.25)
}
\keyword{survey}
