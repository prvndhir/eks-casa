echo '-------Installing KubeArmor on EKS Cluster (typically in ~2 mins)'
starttime=$(date +%s)

# Add helm chart repo
helm repo add kubearmor https://kubearmor.github.io/charts 
helm repo update kubearmor

# Install KubeArmor
helm upgrade --install kubearmor-operator kubearmor/kubearmor-operator -n zumigo-kubearmor --create-namespace
kubectl apply -f ./kubearmor-sample-config.yaml

# Install KubeArmor CLI
curl -sfL http://get.kubearmor.io/ | sudo sh -s -- -b ~/eks-casa

# Deploy a test nginx app
kubectl create namespace nginx
kubectl create deployment nginx --image=nginx -n nginx

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "" | awk '{print $1}'
echo "-------Total time to install KubeArmor with karmor CLI is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by PraveenDhir"
echo "-------Email me if any suggestions or issues prvn.dhir@gmail.com"
echo "" | awk '{print $1}'