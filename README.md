
 ## How to Access
1) kubectl get svc   ##Get load balancer
2) update above "Load Balncer Name" in  "Go-daddy site"   >  ( sapp1 - LB )

http://sapp1.bathur.xyz/simpleapp/

## Cleanup Setps

kubectl delete -f simpleapp-deploy.yaml
kubectl delete -f simpleapp-ingress-rules.yaml

## Local Access
http://127.0.0.1:8010/simpleapp/