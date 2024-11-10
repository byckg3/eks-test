# eks-test


### terraform commands
- terraform init
- terraform fmt
- terraform plan
- terraform apply
- terraform destroy -auto-approve


### aws cli commands
- aws eks --region ap-northeast-1 update-kubeconfig \\\
  --name $(terraform output -raw cluster_name)


### k8s commands
- kubectl cluster-info
- kubectl get no( nodes )
- kubectl get po( pods )
- kubectl get svc( services )
- kubectl get deploy( deployments )
- kubectl delete all --all
- kubectl delete deployment <DEPLOY_NAME>
- kubectl apply -f .
- kubectl rollout status deploy
- rm *.yaml
- kubectl describe pod <POD_NAME>
- kubectl port-forward <POD_NAME> <LOCALHOST_PORT>:<CONTAINER_PORT>
- kubectl exec -it <POD_NAME> /bin/sh




### references
- [Provision an EKS cluster (AWS)](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks)