starttime=$(date +%s)
. ./setenv.sh
echo '-------Deleting the EKS Cluster (typically in ~ 10 mins)'
clusterid=$(kubectl get namespace default -ojsonpath="{.metadata.uid}{'\n'}")
eksctl delete cluster --name $(cat casa_eks_clustername) --region $AWS_REGION

echo '-------Deleting EBS Volumes'
aws ec2 describe-volumes --region $AWS_REGION --query "Volumes[*].{ID:VolumeId}" --filters Name=tag:eks:cluster-name,Values=$(cat casa_eks_clustername) | grep ID | awk '{print $2}' > ebs.list
aws ec2 describe-volumes --region $AWS_REGION --query "Volumes[*].{ID:VolumeId}" --filters Name=tag:kubernetes.io/cluster/$(cat casa_eks_clustername),Values=owned | grep ID | awk '{print $2}' >> ebs.list
for i in $(sed 's/\"//g' ebs.list);do echo $i;aws ec2 delete-volume --volume-id $i --region $AWS_REGION;done

echo '-------Deleting snapshots'
aws ec2 describe-snapshots --owner self --query "Snapshots[*].{ID:SnapshotId}" --filters Name=tag:kanister.io/clustername,Values=$clusterid --region $AWS_REGION | grep ID | awk '{print $2}' > ebssnap.list
for i in $(sed 's/\"//g' ebssnap.list);do echo $i;aws ec2 delete-snapshot --snapshot-id $i --region $AWS_REGION;done

# echo '-------Deleting objects from the bucket'
# aws s3 rb s3://$(cat k10_eks_bucketname) --force

echo '-------Deleting kubeconfig for this cluster'
kubectl config delete-context $(kubectl config get-contexts | grep $(cat casa_eks_clustername) | awk '{print $2}')
echo "" | awk '{print $1}'
endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "-------Total time is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by PraveenDhir"
echo "-------Email me if any suggestions or issues he@PraveenDhir.cloud"
echo "" | awk '{print $1}'
