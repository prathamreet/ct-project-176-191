#!/bin/bash

# Define colors
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${CYAN}Building Docker Images for TaskFlow...${NC}"
docker build -t taskflow-backend:latest ./backend
docker build -t taskflow-worker:latest ./worker
docker build -t taskflow-frontend:latest ./frontend

echo -e "\n${CYAN}Applying Kubernetes Manifests...${NC}"
kubectl apply -f k8s/

echo -e "\n${CYAN}Installing Metrics Server for Autoscaling (HPA)...${NC}"
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl patch deployment metrics-server -n kube-system --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--kubelet-insecure-tls"}]'

echo -e "\n${CYAN}Waiting for Deployments to become ready...${NC}"
kubectl rollout status deployment/redis
kubectl rollout status deployment/backend
kubectl rollout status deployment/worker
kubectl rollout status deployment/frontend

echo -e "\n${CYAN}Port-forwarding the backend service to port 5000...${NC}"
echo -e "${YELLOW}You can now run 'node stress.js' in a new terminal to start the load test.${NC}"
echo -e "${YELLOW}Leave this window open to keep the port-forwarding active. Press Ctrl+C to stop.${NC}"

kubectl port-forward svc/backend-service 5000:5000
