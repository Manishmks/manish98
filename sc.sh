#!/bin/bash
RED='\033[0;31m'
echo -e "${RED} =======CLEANING==========="
mvn clean
echo -e "${RED} =========Installing============="
mvn install
echo -e "${RED} =====BUILDING DOCKER IMAGE======"
echo "Enter Image Name"
read image
docker build -t $image .
echo -e "${RED} ===== PUSHING TO DOCKER ======"
docker push $image
echo -e "${RED} ===== DELETING NAMESPACE ======"
kubectl delete namespaces ems
kubectl delete namespaces database
echo -e "${RED} ===== APPLYING IMAGE ======"
kubectl apply -f deployment.yaml
echo -e "${RED} ===== GETTING PODS ======"
kubectl get pods --all-namespaces
echo -e "${RED} ===== STARTING PROXY ======"
kubectl proxy