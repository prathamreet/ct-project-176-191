#!/bin/bash

# Define colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${RED}Executing Kill Switch! Stopping the Stress Test and Tearing down Kubernetes resources...${NC}"

# Step 1: Delete all Kubernetes resources defined in the k8s directory
echo -e "\n${YELLOW}Deleting Deployments, Services, HPAs, and PVCs...${NC}"
kubectl delete -f k8s/

# Step 2: Remove the Metrics Server
echo -e "\n${YELLOW}Removing Metrics Server...${NC}"
kubectl delete -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml --ignore-not-found=true

# Step 3: Stop any running Node.js stress tests
echo -e "\n${YELLOW}Terminating any running stress tests (node)...${NC}"
pkill node || true

echo -e "\n${GREEN}All TaskFlow resources have been successfully shut down!${NC}"
