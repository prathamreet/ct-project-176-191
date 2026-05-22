#!/bin/bash

# Define colors
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${CYAN}Building Docker Images for TaskFlow...${NC}"
docker build -t taskflow-backend:v4 ./services/backend
docker build -t taskflow-worker:v4 ./services/worker
docker build -t taskflow-frontend:v4 ./services/frontend

echo -e "\n${CYAN}Applying Kubernetes Manifests...${NC}"
kubectl apply -f infra/k8s/

echo -e "\n${CYAN}Installing Metrics Server for Autoscaling (HPA)...${NC}"
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl patch deployment metrics-server -n kube-system --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--kubelet-insecure-tls"}]'

echo -e "\n${CYAN}Waiting for Deployments to become ready...${NC}"
kubectl rollout status deployment/redis
kubectl rollout status deployment/backend
kubectl rollout status deployment/worker
kubectl rollout status deployment/frontend

echo -e "\n${CYAN}Port-forwarding services in new terminal windows...${NC}"

# should start in same current working directory path
# Open new terminal windows for each port-forward (Debian/Ubuntu)
gnome-terminal --title="Backend Port-Forward" -- bash -c "kubectl port-forward svc/backend-service 5000:5000"
gnome-terminal --title="Frontend Port-Forward" -- bash -c "kubectl port-forward svc/frontend-service 8080:8080"
gnome-terminal --title="Prometheus Port-Forward" -- bash -c "kubectl port-forward svc/prometheus-service 9090:9090"
gnome-terminal --title="Grafana Port-Forward" -- bash -c "kubectl port-forward svc/grafana-service 3000:3000"

echo -e "\n${GREEN}All services have been deployed and port-forwarded!${NC}"
echo -e "${YELLOW}You can now run 'node scripts/stress.js' in this terminal to start the load test.${NC}"
echo -e "${CYAN}Backend:${NC} http://localhost:5000"
echo -e "${CYAN}Frontend:${NC} http://localhost:8080"
echo -e "${CYAN}Prometheus:${NC} http://localhost:9090"
echo -e "${CYAN}Grafana:${NC} http://localhost:3000"
