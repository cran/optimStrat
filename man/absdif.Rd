\name{absdif}
\alias{absdif}
\title{Absolute Difference}
\description{Compute the absolute differences between \code{x} and \code{y}.}
\usage{
absdif(x, y)
}
\arguments{
  \item{x}{a numeric vector, matrix or data frame.}
  \item{y}{a numeric vector, matrix or data.frame.}
}
\details{
Compute the absolute differences between \code{x} and \code{y} componentwise.

If \code{x} and \code{y} are vectors of different length, the elements of the shortest one will be recycled as necessary. If matrices or data frames, they should be of the same dimension.}
\value{
An object with the absolute differences between \code{x} and \code{y}.}
\examples{
absdif(1:10, 10:1)

x<- matrix(1:12, 4, 3)
y<- matrix(12:1, 4, 3)
absdif(x, y)
}