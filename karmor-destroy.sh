starttime=$(date +%s)
echo '-------Deleting KubeArmor from the EKS Cluster (typically in few mins)'

# Uninstall KubeArmor
helm uninstall kubearmor-operator -n zumigo-kubearmor
kubectl delete ns nginx
kubectl delete ns zumigo-kubearmor

echo "" | awk '{print $1}'
endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "-------Total time is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by PraveenDhir"
echo "-------Email me if any suggestions or issues he@PraveenDhir.cloud"