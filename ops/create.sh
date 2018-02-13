helm install -f nginx.yaml --name nginx stable/nginx-ingress
helm install -f jenkins.yaml --name jenkins stable/jenkins

kubectl create -f ingress.yaml
