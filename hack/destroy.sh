NAMESPACE=${3:-default}

helm uninstall --namespace $NAMESPACE menu
helm uninstall --namespace $NAMESPACE kitchen
helm uninstall --namespace $NAMESPACE check

kubectl delete secret secret-credentials
kubectl delete namespace $NAMESPACE