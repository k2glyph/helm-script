helm delete --purge $1
kubectl delete pv $(kubectl get pv -n $2 | grep "mongo"| awk '{print $1 }') -n $2
kubectl delete pvc $(kubectl get pvc -n $2 | grep "mongo"| awk '{print $1 }') -n $2