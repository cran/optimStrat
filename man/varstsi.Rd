\name{varstsi}
\alias{varstsi}
\title{Variance of STSI Sampling with the HT Estimator}
\description{Compute the design variance of the Horvitz-Thompson estimator of the total of \code{y} under Stratified Simple Random Sampling, where strata are indicated by \code{stratum} and the sample sizes by stratum are given by \code{nh}.}
\usage{
varstsi(y,stratum,nh)
}
\arguments{
  \item{y}{a numeric vector giving the values of the study variable.}
  \item{stratum}{a vector indicating the stratum to which each element belongs.}
  \item{nh}{a vector indicating the sample size of the stratum to which each element belongs.}
  }
\details{
The variance of the Horvitz-Thompson estimator under Stratified Simple Random Sampling is computed as: \eqn{V_{STSI}\left[\hat{t}_{HT}\right] = \sum_{h} V_{h}}{V_STSI [t_HT] = \Sigma_h V_h} with
\deqn{V_{h} = \frac{N_{h}^{2}}{n_{h}}\left(1-\frac{n_{h}}{N_{h}}\right)S_{y,U_{h}}^{2}}{V_h = (N_h^2)/n_h (1-(n_h/N_h)) (S_y,h)^2}
where \eqn{S_{y,U_{h}}^{2}}{(S_y,h)^2} is the variance of \code{y} in the \eqn{h}th stratum.

The variance of Simple Random Sampling is computed if \code{stratum} is a constant.
}
\value{
A numeric value giving the variance of the Horvitz-Thompson estimator under Stratified Simple Random Sampling.
}
\seealso{\code{\link{stratify}} for a method to define the strata; \code{\link{optiallo}} for Neyman optimal allocation of the sample; \code{\link{varpips}} for the variance of the Horvitz-Thompson estimator under probability proportional-to-size sampling; \code{\link{varpipspos}} for the variance of the poststratified estimator under probability proportional-to-size sampling; \code{\link{varstsipos}} for the variance of the poststratified estimator under stratified simple random sampling; \code{\link{varpipsreg}} for the variance of the regression estimator under probability proportional-to-size sampling; \code{\link{varstsireg}} for the variance of the regression estimator under stratified simple random sampling.
}
\references{
Sarndal, C.E., Swensson, B. and Wretman, J. (1992). \emph{Model Assisted Survey Sampling}. Springer.
}
\examples{
x<- 1 + sort( rgamma(5000, shape=4/9, scale=108) ) #simulating the auxiliary variable
st1<- optiallo(n=100,x=x^0.75,H=6)
y<- simulatey(x,b0=10,b1=1,b2=1.25,b4=0.75,rho=0.95)
varstsi(y,stratum=st1$stratum,nh=st1$nh)
}
\keyword{survey}
