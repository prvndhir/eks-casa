helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update

helm install falco \
  -f https://raw.githubusercontent.com/PraveenDhirhe/eks-casa/main/yong-k8saudit.yaml \
  --set falcosidekick.enabled=true \
  --set falcosidekick.webui.enabled=true falcosecurity/falco \
  -n yong-falco \
  --create-namespace
