#-------Set the environment variables"
export MY_CLUSTER=ekstest           #Customize your cluster name
export MY_INSTANCE_TYPE=t3a.large   #Customize your favorite machine type
export MY_REGION=eu-west-1          #Customize your favorite region
export MY_ZONE=euw1-az1             #Customize your favorite zone
export MY_K8S_VERSION=1.31          #Customize your Kubernetes Version
export MY_BUCKET=bucket4velero1     #Customize your bucket name
source ~/.bashrc                    #Set environment variables
