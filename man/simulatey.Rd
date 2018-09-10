\name{simulatey}
\alias{simulatey}
\title{Simulate the Study Variable}
\description{Simulate values for the study variable based on the auxiliary variable \code{x} and the parameters of a superpopulation model.}
\usage{
simulatey(x, b0, b1, b2, b4, rho=NULL, b3=NULL)
}
\arguments{
  \item{x}{a positive numeric vector giving the values of the auxiliary variable.}
  \item{b0}{a number giving the intercept of the trend term in the superpopulation model.}
  \item{b1}{a number giving the scale of the trend term in the superpopulation model.}
  \item{b2}{a number giving the shape of the trend term in the superpopulation model.}
  \item{b4}{a number giving the shape of the spread term in the superpopulation model.}
  \item{rho}{a number giving the absolute value of the desired correlation between \code{x} and the vector to be simulated.}
  \item{b3}{a nonnegative number giving the scale of the spread term in the superpopulation model. Ignored if \code{rho} is given (see \sQuote{Details}).}
}
\details{
The values of the study variable \code{y} are simulated using a superpopulation model defined as follows:
\deqn{Y_{k}=\beta_{0}+\beta_{1}x_{k}^{\beta_{2}}+\epsilon_{k}}{Y_k = \beta_0 + \beta_1 x_k^\beta_2 + \epsilon_k}
with \eqn{\epsilon_{k} ~ N(0,\beta_{3}x_{k}^{\beta_{4}})}{\epsilon_k ~ N(0 , \beta_3 x_k^\beta_4)}.

Note that \code{b3} defines the degree of association between \code{x} and \code{y}: the larger \code{b3}, the smaller the correlation, \code{rho}, and vice versa. For this reason only one of them should be defined. If both are defined, \code{b3} will be ignored.

The sign of the correlation should be given through \code{b1} (see \sQuote{Examples}).

Depending on the value of \code{b2}, some correlations cannot be reached, e.g. if \code{b2=2} it is pointless to set \code{rho=1}. In those cases, \code{b3} will automatically be set to zero and \code{rho} will be ignored (see \sQuote{Examples}).
}
\value{
A numeric vector giving the simulated value of \code{y} associated to each value in \code{x}.
}
%\references{}
\examples{
#Linear trend and homocedasticity
x<- 1 + sort( rgamma(5000, shape=4/9, scale=108) )
y<- simulatey(x, b0=0, b1=1, b2=1, b4=0, rho=0.90)
plot(x, y)

#Linear trend and heterocedasticity
y<- simulatey(x, b0=0, b1=1, b2=1, b4=1, rho=0.90)
plot(x, y)

#Quadratic trend and homocedasticity
y<- simulatey(x, b0=0, b1=1, b2=2, b4=0, rho=0.80)
plot(x, y)

#Correlation of minus one
y<- simulatey(x, b0=0, b1=-1, b2=1, b4=0, rho=1)
cor(x, y)
plot(x, y)

#Desired correlation cannot be attained
y<- simulatey(x, b0=0, b1=1, b2=3, b4=0, rho=0.99)
cor(x, y)
plot(x, y)
}
\keyword{survey}
