\name{varstsi}
\alias{varstsi}
\title{Variance of STSI Sampling with the HT Estimator}
\description{Compute the design variance of the Horvitz-Thompson estimator of the total of \code{y} under Stratified Simple Random Sampling, where strata are indicated by \code{stratum} and the sample of size \code{n} is allocated using Neyman allocation with respect to \code{x}.}
\usage{
varstsi(n, x, y = x, stratum)
}
\arguments{
  \item{n}{a positive integer indicating the desired sample size.}
  \item{x}{a positive numeric vector giving the values of the auxiliary variable that is used in order to allocate the sample size into the strata.}
  \item{y}{a numeric vector giving the values of the study variable. By default \code{y = x}.}
  \item{stratum}{a vector indicating the stratum to which each element belongs.}
}
\details{
A sample of size \eqn{n} is allocated into the strata using \eqn{x}-optimal allocation, i.e.
\deqn{n_{h} \propto N_{h}S_{x,U_{h}}}{n_h propto N_h S_x,h}
where \eqn{N_h} is the size of the \eqn{h}th stratum, \eqn{S_{x,U_{h}}}{S_x,h} is the standard deviation of \code{x} in the \eqn{h}th stratum and \eqn{propto} stands for \sQuote{proportional to}.

If \eqn{n_{h}>N_{h}}{n_h > N_h} for at least one stratum, \eqn{n_h} is set equal to \eqn{N_h} in those strata and optimal allocation is used again for the remaining strata with the remaining sample size.

Once the \eqn{n_h} are obtained, the variance of the Horvitz-Thompson estimator under Stratified Simple Random Sampling is computed as: \eqn{V_{STSI}\left[\hat{t}_{HT}\right] = \sum_{h} V_{h}}{V_STSI [t_HT] = \Sigma_h V_h} with
\deqn{V_{h} = \frac{N_{h}^{2}}{n_{h}}\left(1-\frac{n_{h}}{N_{h}}\right)S_{y,U_{h}}^{2}}{V_h = (N_h^2)/n_h (1-(n_h/N_h)) (S_y,h)^2}
where \eqn{S_{y,U_{h}}^{2}}{(S_y,h)^2} is the variance of \code{y} in the \eqn{h}th stratum.

Proporional allocation is obtained if \code{x} is a constant.

The variance of Simple Random Sampling is computed if \code{stratum} is a constant.
}
\value{
A list containing the following:
\item{variance}{a vector of length one giving the variance of the Horvitz-Thompson estimator under Stratified Simple Random Sampling.}
\item{nh}{a vector with length equal to the number of strata giving the size of the sample in each stratum.}
}
\seealso{\code{\link{stratify}} for a method to define the strata.}
\references{
Sarndal, C.E., Swensson, B. and Wretman, J. (1992). \emph{Model Assisted Survey Sampling}. Springer.
}
\examples{
x<- 1 + sort( rgamma(5000, shape=4/9, scale=108) ) #simulating the auxiliary variable
y<- rgamma(x, shape=1, scale=x) #simulating the study variable

st1<- rep(1:5, each=1000) #defining the strata
z1<- varstsi(n=500, x=x, y=y, stratum=st1)
z1$variance

st2<- stratify(x, H=5) #A better way to stratify
z2<- varstsi(n=500, x=x, y=y, stratum=st2)
z2$variance
}
\keyword{survey}
