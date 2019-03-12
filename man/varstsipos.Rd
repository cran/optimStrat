\name{varstsipos}
\alias{varstsipos}
\title{
Design variance of a STSI--pos sampling strategy.
}
\description{
Compute the design variance of the poststratified estimator of the total of \code{y} under Stratified Simple Random Sampling, where strata are indicated by \code{stratum} and the sample of size \code{n} is allocated using Neyman allocation with respect to \code{x}.
}
\usage{
varstsipos(y, stratum, nh, poststratum)
}
\arguments{
  \item{y}{a numeric vector giving the values of the study variable.}
  \item{stratum}{a vector indicating the stratum to which each element belongs.}
  \item{nh}{a vector indicating the sample size of the stratum to which each element belongs.}
  \item{poststratum}{a vector indicating the poststratum to which each element belongs.}
}
\details{
A sample of size \eqn{n} is allocated into the strata using \eqn{x}-optimal allocation, i.e.
\deqn{n_{h} \propto N_{h}S_{x,U_{h}}}{n_h propto N_h S_x,h}
where \eqn{N_h} is the size of the \eqn{h}th stratum, \eqn{S_{x,U_{h}}}{S_x,h} is the standard deviation of \code{x} in the \eqn{h}th stratum and \eqn{propto} stands for \sQuote{proportional to}.

If \eqn{n_{h}>N_{h}}{n_h > N_h} for at least one stratum, \eqn{n_h} is set equal to \eqn{N_h} in those strata and optimal allocation is used again for the remaining strata with the remaining sample size.

Once the \eqn{n_h} are obtained, the variance of the poststratified estimator under Stratified Simple Random Sampling is computed as: \eqn{V_{STSI}\left[\hat{t}_{HT}\right] = \sum_{h} V_{h}}{V_STSI [t_HT] = \Sigma_h V_h} with
\deqn{V_{h} = \frac{N_{h}^{2}}{n_{h}}\left(1-\frac{n_{h}}{N_{h}}\right)S_{E,U_{h}}^{2}}{V_h = (N_h^2)/n_h (1-(n_h/N_h)) (S_E,h)^2}
where \eqn{S_{E,U_{h}}^{2}}{(S_E,h)^2} is the variance of \code{E} in the \eqn{h}th stratum with \eqn{E_{k}=y_{k}-B_{g}}{E_k = y_k - B_g} and \eqn{B_{g}=\bar{y}_{g}}{B_g = ybar_g}.
}
\value{A numeric value giving the variance of the poststratified estimator under Stratified Simple Random Sampling.}
\seealso{
\code{\link{varpips}} for the variance of the Horvitz-Thompson estimator under probability proportional-to-size sampling; \code{\link{varstsi}} for the variance of the Horvitz-Thompson estimator under stratified simple random sampling; \code{\link{varpipspos}} for the variance of the poststratified estimator under probability proportional-to-size sampling; \code{\link{varpipsreg}} for the variance of the regression estimator under probability proportional-to-size sampling; \code{\link{varstsireg}} for the variance of the regression estimator under stratified simple random sampling.
}
\examples{
x<- 1 + sort( rgamma(5000, shape=4/9, scale=108) ) #simulating the auxiliary variable
strat1<- optiallo(n=150,x^0.75,H=6)
post1<- stratify(x^1.25,H=6)
y<- simulatey(x,b0=10,b1=1,b2=1.25,b4=0.75,rho=0.95)
varstsipos(y, stratum=strat1$stratum,nh=strat1$nh,poststratum=post1)
}
\keyword{survey}
