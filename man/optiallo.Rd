\name{optiallo}
\alias{optiallo}
\title{Variance of STSI Sampling with the HT Estimator}
\description{Compute the design variance of the Horvitz-Thompson estimator of the total of \code{y} under Stratified Simple Random Sampling, where strata are indicated by \code{stratum} and the sample of size \code{n} is allocated using Neyman allocation with respect to \code{x}.}
\usage{
optiallo(n, x, y = x, stratum)
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

If \eqn{n_{h}>N_{h}}{n_h > N_h} for at least one stratum, then \eqn{n_h} is set equal to \eqn{N_h} in those strata and optimal allocation is used again for the remaining strata with the remaining sample size.

Once the \eqn{n_h} are obtained, the variance of the Horvitz-Thompson estimator under Stratified Simple Random Sampling is computed as: \eqn{V_{STSI}\left[\hat{t}_{HT}\right] = \sum_{h} V_{h}}{V_STSI [t_HT] = \Sigma_h V_h} with
\deqn{V_{h} = \frac{N_{h}^{2}}{n_{h}}\left(1-\frac{n_{h}}{N_{h}}\right)S_{y,U_{h}}^{2}}{V_h = (N_h^2)/n_h (1-(n_h/N_h)) (S_y,h)^2}
where \eqn{S_{y,U_{h}}^{2}}{(S_y,h)^2} is the variance of \code{y} in the \eqn{h}th stratum.
}
\value{
A vector of length 1 giving the variance of the Horvitz-Thompson estimator under Stratified Simple Random Sampling.
}
\seealso{\code{\link{stratify}} for a method to define the strata.}
\references{
Sarndal, C.E., Swensson, B. and Wretman, J. (1992). \emph{Model Assisted Survey Sampling}. Springer.
}
\examples{
x<- sort(rgamma(100000,3,1/4)) #simulating the auxiliary variable
y<- rgamma(x,x^2,x) #simulating the study variable
st<- rep(1:10,each=10000) #defining the strata
optiallo(n=500,x=x,y=y,stratum=st)

st2<- stratify(x,10) #A better way to stratify
optiallo(n=500,x=x,y=y,stratum=st2)
}
\keyword{survey}
