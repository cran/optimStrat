pinc <-
function(n, x) {
    x1 <- sign(min(x))
    x2 <- sign(max(x))
    if (x1 * x2 == -1) {
        stop("All the x-values must be either non-negative or non-positive")
    }
    pik <- n * x/sum(x)
    while (max(pik) > 1) {
        pik <- pmin(1,pik)
        n2<- sum(pik == 1)
        pik2<- pik[pik < 1]
        pik[pik < 1] <- (n - n2) * pik2/sum(pik2)
    }
    pik
}
