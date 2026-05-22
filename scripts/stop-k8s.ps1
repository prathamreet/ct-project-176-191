Write-Host "Executing Kill Switch! Stopping the Stress Test and Tearing down Kubernetes resources..." -ForegroundColor Red

Write-Host "`nDeleting Deployments, Services, HPAs, and PVCs..." -ForegroundColor Yellow
kubectl delete -f infra/k8s/

Write-Host "`nRemoving Metrics Server..." -ForegroundColor Yellow
kubectl delete -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml --ignore-not-found=true

Write-Host "`nTerminating any running stress tests (node)..." -ForegroundColor Yellow
Stop-Process -Name "node" -ErrorAction SilentlyContinue

Write-Host "`nAll TaskFlow resources have been successfully shut down!" -ForegroundColor Green
