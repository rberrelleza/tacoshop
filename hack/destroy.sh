NAMESPACE=${1:-default}

helm uninstall --namespace $NAMESPACE menu
helm uninstall --namespace $NAMESPACE kitchen
helm uninstall --namespace $NAMESPACE check

kubectl delete secret --namespace $NAMESPACE secret-credentials
kubectl delete namespace $NAMESPACE