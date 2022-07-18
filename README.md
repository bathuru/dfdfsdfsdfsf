
### Prerequisite
1.Create a kubernets cluster using eks/aks <br>
2.$kubectl get svc    ##Get load balancer <br>
3.update above "Load Balncer Name" in  "Go-daddy site"   >  ( sapp1 - LB )

### Application Deploy
$ kubectl apply -f simpleapp-deploy.yaml <br>
$ kubectl apply -f simpleapp-ingress-rules.yaml

### Application Access
http://app1.bathuru.shop/simpleapp/

### Application Cleanup

$ kubectl delete -f simpleapp-deploy.yaml <br>
$ kubectl delete -f simpleapp-ingress-rules.yaml

### Local Access
http://127.0.0.1:8010/simpleapp/
