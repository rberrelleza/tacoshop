registry=${1:-ramiro}
tag=${2:-latest}
namespace=${3:-default}

echo kubectl create secret generic secret-credentials --save-config --dry-run=client --from-literal=AWS_REGION="us-east-1" --from-literal=AWS_DEFAULT_REGION="us-east-1" --from-literal=AWS_SECRET_ACCESS_KEY=test --from-literal=AWS_ACCESS_KEY_ID=test --from-literal=AWS_ENDPOINT=http://localstack:4566 -o yaml | kubectl apply --namespace $namespace -f -
echo helm upgrade --install localstack https://github.com/localstack/helm-charts/releases/download/localstack-0.6.1/localstack-0.6.1.tgz -f localstack/values.yaml
echo helm upgrade --install menu ./menu/chart --set image=${OKTETO_BUILD_MENU_IMAGE} --namespace $namespace
echo helm upgrade --install kitchen ./kitchen/chart --set image=${OKTETO_BUILD_KITCHEN_IMAGE} --namespace $namespace
echo helm upgrade --install check ./check/chart --set image=${OKTETO_BUILD_CHECK_IMAGE} --namespace $namespace