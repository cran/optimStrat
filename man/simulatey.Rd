\name{simulatey}
\alias{simulatey}
\title{Simulate the Study Variable}
\description{Simulate values for the study variable based on the auxiliary variable \code{x} and the parameters of a superpopulation model.}
\usage{
simulatey(x, b0, b1, b2, b3, b4)
}
\arguments{
  \item{x}{a positive numeric vector giving the values of the auxiliary variable.}
  \item{b0}{a number giving the intercept of the trend term in the superpopulation model.}
  \item{b1}{a number giving the scale of the trend term in the superpopulation model.}
  \item{b2}{a number giving the shape of the trend term in the superpopulation model.}
  \item{b3}{a nonnegative number giving the scale of the spread term in the superpopulation model.}
  \item{b4}{a number giving the shape of the spread term in the superpopulation model.}
}
\details{
The values of the study variable \code{y} are simulated using a superpopulation model defined as follows:
\deqn{Y_{k}=\beta_{0}+\beta_{1}x_{k}^{\beta_{2}}+\epsilon_{k}}{Y_k = \beta_0 + \beta_1 x_k^\beta_2 + \epsilon_k}
with \eqn{\epsilon_{k} ~ N(0,\beta_{3}^{0.5}x_{k}^{\beta_{4}})}{\epsilon_k ~ N(0 , \beta_3^0.5 x_k^\beta_4)}.
}
\value{
A numeric vector giving the simulated value of \code{y} associated to each value in \code{x}.
}
%\references{}
\examples{
#Linear trend and homocedasticity
x<- 1+sort(rgamma(5000,shape=4/9,scale=108))
y<- simulatey(x,b0=0,b1=1,b2=1,b3=100,b4=0)
plot(x,y)

#Linear trend and heterocedasticity
y<- simulatey(x,b0=0,b1=1,b2=1,b3=0.05,b4=1)
plot(x,y)

#Quadratic trend and homocedasticity
y<- simulatey(x,b0=0,b1=1,b2=2,b3=1e+08,b4=0)
plot(x,y)
}
\keyword{survey}
