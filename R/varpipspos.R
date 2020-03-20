varpipspos <-
function(y,x_des,n,poststratum) {
   post2<- unique(poststratum)
   poststratum2<- (1:length(post2))[poststratum]
   ybarg<- as.vector(by(y,poststratum2,mean))
   ybarg<- ybarg[poststratum2]
   E2<- y-ybarg
   varpips(E2,x_des,n)        
}
