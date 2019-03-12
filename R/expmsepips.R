expmsepips <-
function(x,pik,n,Beta11,Beta12,Beta21,Beta22,Delta12,Rfy,ak=1) {
   vk1<- vk(x,Beta11,Beta12,Delta12,ak)
   gbk<- gk(x,Beta21,Beta22)
   sigmahat<- var(vk1$fbk)*((1/(Rfy^2))-1)/mean(gbk^2)
   pik<- pinc(n,pik)
   varpips(vk1$fbk-vk1$fdk,pik,n)+sigmahat*(sum((gbk^2)/pik)-sum(gbk^2))
}
