echo '-------Remove Velero for EKS and Clean up (typically in 3 mins)'
starttime=$(date +%s)
. ./setenv.sh

velero uninstall --force
aws s3 rm s3://$(cat bucket4velero1) --recursive
# aws s3 rb s3://$(cat bucket4velero1) --force
aws iam delete-user-policy \
    --user-name vuser4zumigo \
    --policy-name vpolicy
aws iam delete-access-key --user-name vuser4zumigo --access-key-id \
    $(grep AccessKeyId vuser4zumigo.txt | awk '{print $2}' | sed -e 's/\"//g' | sed -e 's/\,//g')
aws iam delete-user --user-name vuser4zumigo

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "" | awk '{print $1}'
echo "-------Total time to clean up the env is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by PraveenDhir"
echo "-------Email me if any suggestions or issues prvn.dhir@gmail.com"
echo "" | awk '{print $1}'