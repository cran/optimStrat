\name{expgreg}
\alias{expgreg}
\title{Expected variance of the general regression estimator}
\description{
Compute the expected design variance of the general regression estimator of the total of a study variable under different sampling designs.
}
\usage{
expgreg(x, b11, b12, b21, b22, d12, Rfy, n, design = NULL, 
        stratum = NULL, x_des = NULL, inc.p = NULL, ...)
}

\arguments{
   \item{x}{design matrix with the variables to be used into the GREG estimator.}
  \item{b11}{a numeric vector of length equal to the number of variables in \code{x} giving the coefficients of the trend term in the \emph{true} superpopulation model (see \sQuote{Details}).}
  \item{b12}{a numeric vector of length equal to the number of variables in \code{x} giving the exponents of the trend term in the \emph{true} superpopulation model (see \sQuote{Details}).}
  \item{b21}{a numeric vector of length equal to the number of variables in \code{x} giving the coefficients of the spread term in the \emph{true} superpopulation model (see \sQuote{Details}).}
  \item{b22}{a numeric vector of length equal to the number of variables in \code{x} giving the exponents of the spread term in the \emph{true} superpopulation model (see \sQuote{Details}).}
  \item{d12}{a numeric vector of length equal to the number of variables in \code{x} giving the exponents of the trend term in the \emph{assumed} superpopulation model (see \sQuote{Details}).}
  \item{Rfy}{a number giving the square root of the coefficient of determination between the auxiliary variables and the study varible.}
  \item{n}{either a positive number indicating the (expected) sample size (when \code{design} is one of 'srs', 'poi', 'pips' or \code{NULL}) or a numeric vector indicating the sample size of the strata to which each element belongs (when \code{design} is 'stsi') (see \sQuote{Examples}).}
  \item{design}{a character string giving the sampling design. It must be one of 'srs' (simple random sampling without replacement),  'poi' (Poisson sampling), 'stsi' (stratified simple random sampling), 'pips' (Pareto \eqn{\pi}ps sampling) or \code{NULL} (see \sQuote{Details}).}
  \item{stratum}{a vector indicating the stratum to which every unit belongs. Only used if \code{design} is 'stsi'.}
  \item{x_des}{a positive numeric vector giving the values of the auxiliary variable that is used for defining the inclusion probabilities. Only used if \code{design} is 'poi' or 'pips'.}
  \item{inc.p}{a matrix giving the first and second order inclusion probabilities. Only used if \code{design} is \code{NULL}.}
  \item{\dots}{other arguments passed to \code{\link{lm}} (see \sQuote{Details}).}
}

\details{
The expected variance of the general regression estimator under different sampling designs is computed.

It is assumed that the underlying superpopulation model is of the form
\deqn{Y_{k} = f(x_{k}|\delta_{1}) + \epsilon_{k}}{Y_k = f(x_k|\delta_1) + \epsilon_k}
with \eqn{E\epsilon_{k}=0}{E\epsilon_k = 0}, \eqn{V\epsilon_{k}= \sigma_{0}^{2}g^{2}(x_{k}|\delta_{2})}{V\epsilon_k = \sigma_0^2 g(x_k|\delta_2)^2} and \eqn{Cov(\epsilon_{k},\epsilon_{l})=0}{Cov(\epsilon_k , \epsilon_l) = 0}.

But the true generating model is in fact of the form
\deqn{Y_{k} = f(x_{k}|\beta_{1}) + \epsilon_{k}}{Y_k = f(x_k|\beta_1) + \epsilon_k}
with \eqn{E\epsilon_{k}=0}{E\epsilon_k = 0}, \eqn{V\epsilon_{k}= \sigma^{2}g^{2}(x_{k}|\beta_{2})}{V\epsilon_k = \sigma^2 g(x_k|\beta_2)^2} and \eqn{Cov(\epsilon_{k},\epsilon_{l})=0}{Cov(\epsilon_k , \epsilon_l) = 0}.

Where
\deqn{f(x_{k}|\delta_{1}) = \sum_{j=1}^{J}\delta_{1,j}x_{jk}^{\delta_{1,J+j}},}{f(x_k|\delta_1) = \Sigma_[j=1]^J \delta_[1,j] x_[j,k]^\delta_[1,J+j],}
\deqn{g(x_{k}|\delta_{2}) = \sum_{j=1}^{J}\delta_{2,j}x_{jk}^{\delta_{2,J+j}},}{f(g_k|\delta_2) = \Sigma_[j=1]^J \delta_[2,j] x_[j,k]^\delta_[2,J+j],}
\deqn{f(x_{k}|\beta_{1}) = \sum_{j=1}^{J}\beta_{1,j}x_{jk}^{\beta_{1,J+j}},}{f(x_k|\beta_1) = \Sigma_[j=1]^J \beta_[1,j] x_[j,k]^\beta_[1,J+j],}
\deqn{g(x_{k}|\beta_{2}) = \sum_{j=1}^{J}\beta_{2,j}x_{jk}^{\beta_{2,J+j}}.}{f(g_k|\beta_2) = \Sigma_[j=1]^J \beta_[2,j] x_[j,k]^\beta_[2,J+j].}

\itemize{
\item the coefficients \eqn{\beta_{1,j}}{\beta_[1,j]} (\eqn{j=1,\cdots,J}{j = 1,...,J}) are given by \code{b11};
\item the exponents \eqn{\beta_{1,j}}{\beta_[1,j]} (\eqn{j=J+1,\cdots,2J}{j=J+1,...,2J}) are given by \code{b12};
\item the coefficients \eqn{\beta_{2,j}}{\beta_[2,j]} (\eqn{j=1,\cdots,J}{j = 1,...,J}) are given by \code{b21};
\item the exponents \eqn{\beta_{2,j}}{\beta_[2,j]} (\eqn{j=J+1,\cdots,2J}{j = J+1,...,2J}) are given by \code{b22};
\item the exponents \eqn{\delta_{1,j}}{\delta_[1,j]} (\eqn{j=J+1,\cdots,2J}{j = J+1,...,2J}) are given by \code{d12}.
}

The expected variance of the GREG estimator is approximated by
\deqn{E\left(V\left(\hat{t}\right)\right) = V\left(\hat{t}_{z}\right) + \hat{\sigma}^{2}\sum_{k=1}^{N}\left(\frac{1}{\pi_{k}}-1\right)g^{2}(x_{k}|\beta_{2})}{E(V(t_hat)) = V(t*_hat) + \sigma*^2 \Sigma_[k=1]^N (1/\pi_k - 1)g(x_k|\beta_2)^2}
where
\deqn{V\left(\hat{t}_{z}\right) = \sum_{k=1}^{N}\sum_{l=1}^{N}\pi_{kl}\frac{z_{k}}{\pi_{k}}\frac{z_{l}}{\pi_{l}} - \left(\sum_{k=1}^{N}z_{k}\right)^{2}}{V(t*_hat) = \Sigma_[k=1]^N \Sigma_[l=1]^N \pi_kl (z_k*z_l)/(\pi_k*\pi_l) - (\Sigma_[k=1]^N z_k)^2}
and
\deqn{\hat{\sigma}^{2} = \frac{S^{2}_{f}}{\bar{g^{2}}}\left(\frac{1}{R^{2}_{fy}}-1\right),}{\sigma*^2 = S^2_f/(g^2)_bar*(1/R_fy^2 - 1),}
\deqn{z_{k} = \left(x_{k}^{\beta}-x_{k}^{\delta}A\right)\beta_{1}^{**},}{z_k = (x_k^\beta - x_k^\delta*A)*\beta**_1,}
\deqn{S^{2}_{f} = \sum_{k=1}^{N}(f(x_{k}|\beta_{1})-\bar{f})^{2}/N,}{S^2_f = \Sigma_[k=1]^N (f(x_k|\beta_1) - f_bar)^2 / N,}
\deqn{\bar{g^{2}} = \sum_{k=1}^{N}g(x_{k}|\beta_{2})^{2}/N,}{(g^2)_bar = \Sigma_[k=1]^N g(x_k|\beta_2)^2 / N,}
\deqn{x_{k}^{\beta} = \left(x_{1k}^{\beta_{1,J+1}},\cdots,x_{Jk}^{\beta_{1,2J}}\right),}{x_k^\beta = (x_[1k]^(\beta_[1,J+1]),\dots,x_[Jk]^(\beta_[1,2J])),}
\deqn{x_{k}^{\delta} = \left(x_{1k}^{\delta_{1,J+1}},\cdots,x_{Jk}^{\delta_{1,2J}}\right),}{x_k^\delta = (x_[1k]^(\delta_[1,J+1]),\dots,x_[Jk]^(\delta_[1,2J])),}
\deqn{\beta_{1}^{**} = (\beta_{1,1},\cdots,\beta_{1,J})',}{\beta**_1 = (\beta_[1,1],\dots,\beta_[1,J])',}
\deqn{A = \left(\sum_{k=1}^{N}w_{k}x_{k}^{\delta'}x_{k}^{\delta}\right)^{-1}\sum_{k=1}^{N}w_{k}x_{k}^{\delta'}x_{k}^{\beta}.}{A = (\Sigma_[k=1]^N w_k*x_k^\delta'*x_k^\delta)^-1 \Sigma_[k=1]^N w_k*x_k^\delta'*x_k^\beta.} 

\eqn{N} is the population size and \eqn{\pi_{k}}{\pi_k} and \eqn{\pi_{kl}}{\pi_kl} are, respectively, the first and second order inclusion probabilities. \eqn{w_{k}}{w_k} is a weight associated to each element and it represents the inverse of the conditional variance (up to a scalar) of the underlying superpopulation model (see \sQuote{Examples}).

If \code{design=NULL}, the matrix of inclusion probabilities is obtained proportional to the matrix \code{p.inc}. If \code{design} is other than \code{NULL}, the formula for the variance is simplified in such a way that the inclusion probabilities matrix is no longer necessary. In particular:
\itemize{
\item if \code{design='srs'}, only the sample size \code{n} is required;
\item if \code{design='stsi'}, both the stratum ID \code{stratum} and the sample size per stratum \code{n}, are required;
\item if \code{design} is either \code{'pips'} or \code{'poi'}, the inclusion probabilities are obtained proportional to the values of \code{x_des}, corrected if necessary.
}
}

\value{A numeric value giving the expected variance of the general regression estimator for the desired design under the working and true models.}

\references{
Bueno, E. (2018). \emph{A Comparison of Stratified Simple Random Sampling and Probability Proportional-to-size Sampling.} Research Report, Department of Statistics, Stockholm University 2018:6. \url{http://gauss.stat.su.se/rr/RR2018_6.pdf}.
}

\seealso{
\code{\link{expvar}} for the simultaneous calculation of the expected variance of five sampling strategies under a superpopulation model; \code{\link{vargreg}} for the variance of the GREG estimator; \code{\link{desvar}} for the simultaneous calculation of the variance of six sampling strategies; \code{\link{optimApp}} for an interactive application of \code{expgreg}.
}

\examples{
x1<- 1 + sort( rgamma(5000, shape=4/9, scale=108) )
x2<- 1 + sort( rgamma(5000, shape=4/9, scale=108) )
x3<- 1 + sort( rgamma(5000, shape=4/9, scale=108) )
x<- cbind(x1,x2,x3)
expgreg(x,b11=c(1,-1,0),b12=c(1,1,0),b21=c(0,0,1),b22=c(0,0,0.5),
        d12=c(1,1,0),Rfy=0.8,n=150,"pips",x_des=x3)
expgreg(x,b11=c(1,-1,0),b12=c(1,1,0),b21=c(0,0,1),b22=c(0,0,0.5),
        d12=c(1,1,0),Rfy=0.8,n=150,"pips",x_des=x2)
expgreg(x,b11=c(1,-1,0),b12=c(1,1,0),b21=c(0,0,1),b22=c(0,0,0.5),
        d12=c(1,1,0),Rfy=0.8,n=150,"pips",x_des=x2,weights=1/x1)

st1<- optiallo(n=150,x=x3,H=6)
expgreg(x,b11=c(1,-1,0),b12=c(1,1,0),b21=c(0,0,1),b22=c(0,0,0.5),
        d12=c(1,1,0),Rfy=0.8,n=st1$nh,"stsi",stratum=st1$stratum)
expgreg(x,b11=c(1,-1,0),b12=c(1,1,0),b21=c(0,0,1),b22=c(0,0,0.5),
        d12=c(1,0,1),Rfy=0.8,n=st1$nh,"stsi",stratum=st1$stratum)
expgreg(x,b11=c(1,-1,0),b12=c(1,1,0),b21=c(0,0,1),b22=c(0,0,0.5),
        d12=c(1,0,1),Rfy=0.8,n=st1$nh,"stsi",stratum=st1$stratum,weights=1/x1)
}

\keyword{survey}