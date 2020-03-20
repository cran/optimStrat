varstsipos <-
function(y,stratum,nh,poststratum) {
   post2<- unique(poststratum)
   poststratum2<- (1:length(post2))[poststratum]
   ybarg<- as.vector(by(y,poststratum2,mean))
   ybarg<- ybarg[poststratum2]
   E2<- y-ybarg
   varstsi(E2,stratum,nh)        
}
