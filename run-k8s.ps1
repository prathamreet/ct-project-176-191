Write-Host "Building Docker Images for TaskFlow..." -ForegroundColor Cyan
docker build -t taskflow-backend:v3 ./backend
docker build -t taskflow-worker:v3 ./worker
docker build -t taskflow-frontend:v2 ./frontend

Write-Host "`nApplying Kubernetes Manifests..." -ForegroundColor Cyan
kubectl apply -f k8s/

Write-Host "`nInstalling Metrics Server for Autoscaling (HPA)..." -ForegroundColor Cyan
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl patch deployment metrics-server -n kube-system --type='json' -p='[{\"op\": \"add\", \"path\": \"/spec/template/spec/containers/0/args/-\", \"value\": \"--kubelet-insecure-tls\"}]'

Write-Host "`nWaiting for Deployments to become ready..." -ForegroundColor Cyan
kubectl rollout status deployment/redis
kubectl rollout status deployment/backend
kubectl rollout status deployment/worker
kubectl rollout status deployment/frontend

Write-Host "`nPort-forwarding the backend service to port 5000..." -ForegroundColor Cyan
Write-Host "You can now run 'node stress.js' in a new terminal to start the load test." -ForegroundColor Yellow
Write-Host "Leave this window open to keep the port-forwarding active. Press Ctrl+C to stop." -ForegroundColor Yellow

kubectl port-forward svc/backend-service 5000:5000
