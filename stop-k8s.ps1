Write-Host "Executing Kill Switch! Stopping the Stress Test and Tearing down Kubernetes resources..." -ForegroundColor Red

# Step 1: Delete all Kubernetes resources defined in the k8s directory
Write-Host "`nDeleting Deployments, Services, HPAs, and PVCs..." -ForegroundColor Yellow
kubectl delete -f k8s/

# Step 2: Remove the Metrics Server (to fully clean the cluster)
Write-Host "`nRemoving Metrics Server..." -ForegroundColor Yellow
kubectl delete -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml --ignore-not-found=true

# Step 3: Stop any running Node.js stress tests
Write-Host "`nTerminating any running stress tests (node.exe)..." -ForegroundColor Yellow
Stop-Process -Name "node" -ErrorAction SilentlyContinue

Write-Host "`nAll TaskFlow resources have been successfully shut down!" -ForegroundColor Green
