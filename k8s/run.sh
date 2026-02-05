#!/bin/bash

# This script deploys the Shopsphere Ecommerce application on a Kubernetes cluster
# using AWS Secret Manager for managing sensitive information.
# Check if namespace exists

namespace="color-manager-app"

if kubectl get ns "$namespace" &> /dev/null; then
  echo "Deleting Old app in namespace $namespace..."
  kubectl delete ns "$namespace"
else
  echo "Namespace $namespace does not exist. Skipping deletion."
fi


echo "Namespace '$namespace' deleted."
# Apply the Kubernetes manifests
kubectl create namespace "$namespace"



echo " "

current_dir=$(pwd)

kubectl apply -f ${current_dir}/k8s/backend -n $namespace
kubectl apply -f ${current_dir}/k8s/frontend -n $namespace

echo "Waiting for about 5 seconds for all pods to be in running state..."
echo " "
sleep 5
echo " "
echo " ================================================================= "
echo "       All resources                                               "
echo " ================================================================= "
kubectl get pods -n "$namespace"
echo " "
echo " if any issue: kubectl get pods -n $namespace"
echo "kubectl port-forward -n $namespace svc/frontend 8080:80"
echo "Frontend: http://localhost:8080"
echo "Confirm_PODS: kubectl get pods -n $namespace"
echo "Confirm_ALL: kubectl get all -n $namespace"