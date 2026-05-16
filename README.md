<img src="https://capsule-render.vercel.app/api?type=soft&color=gradient&height=10&section=header" width="1080" align="center"/>

> Om Ji Rao (1NH23CS176)  ·  Pratham Reet (1NH23CS191)

<img src="https://capsule-render.vercel.app/api?type=soft&color=gradient&height=10&section=header" width="1080" align="center"/>


# TaskFlow - Scalable Job Processing Engine

A production-ready asynchronous task queue system demonstrating advanced zero-volume Docker orchestration, Multi-Stage container builds for extreme size optimization, and full Kubernetes deployment.


Engineered with Horizontal Pod Autoscaling (HPA) to dynamically provision resources during traffic spikes and Persistent Volume Claims (PVC) to guarantee message broker state safety.

Features a deeply integrated observability pipeline using Kubernetes RBAC API permissions for native Prometheus service discovery and custom Grafana dashboards to track real-time processing throughput and container CPU loads.

---
### Stack

| Service    | Tech              | Role                                     |
| ---------- | ----------------- | ---------------------------------------- |
| Frontend   | Nginx             | Serves UI, proxies API requests          |
| Backend    | Node.js (Express) | Receives tasks, manages state via Redis  |
| Worker     | Node.js           | Pulls tasks from queue and executes them |
| Queue / DB | Redis             | Message broker + ephemeral state store   |
| Metrics    | Prometheus        | Scrapes backend performance data         |
| Dashboard  | Grafana           | Real-time task status and health visuals |



### Docker - Quick Start

```bash
docker-compose up --build -d
docker-compose down
```



### Kubernetes - Quick Start

```bash
./run-k8s.sh        
node stress.js      
./stop-k8s.sh    
```

| Interface   | URL                   |
| ----------- | --------------------- |
| Frontend UI | http://localhost:8080 |
| Backend API | http://localhost:5000 |
| Prometheus  | http://localhost:9090 |
| Grafana     | http://localhost:3000 |


## kubectl Reference

```bash
# Pods
kubectl get pods
kubectl get pods -o wide
# Watch autoscaling live
kubectl get hpa -w

# Networking & Storage
kubectl get services
kubectl get pvc

# Logs & Debugging
kubectl logs -l app=backend
kubectl logs <pod-name>
kubectl describe pod <pod-name>

# Cluster
kubectl cluster-info
kubectl get nodes
```

