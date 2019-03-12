expmsestsi <-
function(x,stratum,nh,Beta11,Beta12,Beta21,Beta22,Delta12,Rfy,ak=1) {
   vk1<- vk(x,Beta11,Beta12,Delta12,ak)
   gbk<- gk(x,Beta21,Beta22)
   sigmahat<- var(vk1$fbk)*((1/(Rfy^2))-1)/mean(gbk^2)
   term1<- sum(as.vector(by(stratum,stratum,length)*by(gbk^2,stratum,sum)/by(nh,stratum,mean)))
   varstsi(vk1$fbk-vk1$fdk,stratum,nh)+sigmahat*(term1-sum(gbk^2))
}
