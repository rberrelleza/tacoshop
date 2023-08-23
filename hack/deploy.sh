REGISTRY=${1:-ramiro}
TAG=${2:-latest}
NAMESPACE=${3:-default}
HOST_SUFFIX=${4:-"-preview"}

MENU_IMAGE=$REGISTRY/menu:$TAG
KITCHEN_IMAGE=$REGISTRY/kitchen:$TAG
CHECK_IMAGE=$REGISTRY/check:$TAG


kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
kubectl create secret generic secret-credentials --namespace $NAMESPACE --save-config --dry-run=client --from-literal=AWS_REGION="us-east-1" --from-literal=AWS_DEFAULT_REGION="us-east-1" --from-literal=AWS_SECRET_ACCESS_KEY="test" --from-literal=AWS_ACCESS_KEY_ID="test" --from-literal=AWS_ENDPOINT="http://localstack:4566" -o yaml | kubectl apply --namespace $NAMESPACE -f -
helm upgrade --install localstack https://github.com/localstack/helm-charts/releases/download/localstack-0.6.1/localstack-0.6.1.tgz -f localstack/values.yaml --namespace $NAMESPACE
helm upgrade --install menu ./menu/chart --set image=${MENU_IMAGE} --namespace $NAMESPACE --set ingress.enabled=true  --set ingress.hosts[0].host="menu${HOST_SUFFIX},ingress.hosts[0].paths[0].path=/,ingress.hosts[0].paths[0].pathType=ImplementationSpecific"
helm upgrade --install kitchen ./kitchen/chart --set image=${KITCHEN_IMAGE} --namespace $NAMESPACE --set ingress.enabled=true --set ingress.hosts[0].host="kitchen${HOST_SUFFIX},ingress.hosts[0].paths[0].path=/,ingress.hosts[0].paths[0].pathType=ImplementationSpecific"
helm upgrade --install check ./check/chart --set image=${CHECK_IMAGE} --namespace $NAMESPACE --set ingress.enabled=true --set ingress.hosts[0].host="check${HOST_SUFFIX},ingress.hosts[0].paths[0].path=/,ingress.hosts[0].paths[0].pathType=ImplementationSpecific"
