Write-Host "Building Docker Images for TaskFlow..." -ForegroundColor Cyan
docker build -t taskflow-backend:v4 ./services/backend
docker build -t taskflow-worker:v4 ./services/worker
docker build -t taskflow-frontend:v4 ./services/frontend

Write-Host "`nApplying Kubernetes Manifests..." -ForegroundColor Cyan
kubectl apply -f infra/k8s/

Write-Host "`nInstalling Metrics Server for Autoscaling (HPA)..." -ForegroundColor Cyan
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl patch deployment metrics-server -n kube-system --type='json' -p='[{\"op\": \"add\", \"path\": \"/spec/template/spec/containers/0/args/-\", \"value\": \"--kubelet-insecure-tls\"}]'

Write-Host "`nWaiting for Deployments to become ready..." -ForegroundColor Cyan
kubectl rollout status deployment/redis
kubectl rollout status deployment/backend
kubectl rollout status deployment/worker
kubectl rollout status deployment/frontend

Write-Host "`nPort-forwarding services in new terminal windows..." -ForegroundColor Cyan

# Open new PowerShell windows for each port-forward
Start-Process powershell -ArgumentList "-NoExit", "-Command", "kubectl port-forward svc/backend-service 5000:5000"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "kubectl port-forward svc/frontend-service 8080:8080"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "kubectl port-forward svc/prometheus-service 9090:9090"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "kubectl port-forward svc/grafana-service 3000:3000"

Write-Host "`nAll services have been deployed and port-forwarded!" -ForegroundColor Green
Write-Host "You can now run 'node scripts/stress.js' in this terminal to start the load test." -ForegroundColor Yellow
Write-Host "Backend: http://localhost:5000" -ForegroundColor Cyan
Write-Host "Frontend: http://localhost:8080" -ForegroundColor Cyan
Write-Host "Prometheus: http://localhost:9090" -ForegroundColor Cyan
Write-Host "Grafana: http://localhost:3000" -ForegroundColor Cyan
