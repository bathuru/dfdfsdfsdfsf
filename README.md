
 ## How to Access
1) kubectl get svc   ##Get load balancer
2) Update above load balncer in godaddy site   >  ( sapp1 - LB )

http://sapp1.bathur.xyz:8080/simpleapp


## Cleanup Setps

kubectl delete -f simpleapp-deploy.yaml
kubectl delete -f simpleapp-ingress-rules.yaml

## Local Access
http://127.0.0.1:8010/simpleapp/