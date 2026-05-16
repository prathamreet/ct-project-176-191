<img src="https://capsule-render.vercel.app/api?type=soft&color=gradient&height=10&section=header" width="1080" align="center"/>
<br>

# TaskFlow - Asynchronous Task Queue System

A clean, multi-container demonstration project showcasing asynchronous background processing, real-time monitoring, and zero-volume Docker orchestration.

## Architecture & Services

| Service        | Technology        | Role                                                              |
| :------------- | :---------------- | :---------------------------------------------------------------- |
| **Frontend**   | Nginx             | Serves the UI and proxies API requests.                           |
| **Backend**    | Node.js (Express) | Receives tasks, manages state in Redis, and exports metrics.      |
| **Worker**     | Node.js           | Background process that pulls tasks from Redis and executes them. |
| **Queue/DB**   | Redis             | Acts as both the message broker and the ephemeral state store.    |
| **Metrics**    | Prometheus        | Automatically scrapes performance data from the backend.          |
| **Visualizer** | Grafana           | Provides a real-time dashboard for task status and system health. |


## Project Structure
```text
├── backend/      # API Server
├── worker/       # Background Worker
├── frontend/     # Web Interface
├── monitoring/   # Prometheus & Grafana Config
└── docker-compose.yml
```


## Key Technical Concepts
*   **Zero-Volume Orchestration**: All configurations (Nginx, Prometheus, Grafana) are embedded directly into custom Docker images. No local file mounting is required.
*   **Asynchronous Pattern**: Tasks are offloaded from the API to the Worker via a Redis queue to ensure the UI remains responsive.
*   **Service Discovery**: Services communicate using internal Docker DNS names (e.g., `http://redis:6379`) instead of IP addresses.
*   **Observability**: Custom Prometheus metrics (`taskflow_tasks_total`, etc.) allow for real-time monitoring of job velocity and success rates.

## Quick Start
1.  **Clone the project** (if you haven't already).
2.  **Launch the system**:
    ```bash
    docker-compose up --build -d
    ```
3.  **Access the interfaces**:
    *   **Frontend UI**: [http://localhost:8080](http://localhost:8080) (Submit tasks here)
    *   **Monitoring Dashboard**: [http://localhost:3000](http://localhost:3000) (Login: `admin` / `admin`)
    *   **Prometheus Targets**: [http://localhost:9090/targets](http://localhost:9090/targets)

## 🚢 Kubernetes Orchestration
The TaskFlow application has been modernized from basic Docker containers into a highly resilient, auto-scaling Kubernetes cluster.

### 🏗️ Architecture & Components
1.  **Frontend (Nginx + HTML/JS)**: Serves the static UI. A reverse proxy inside Nginx routes all `/task` API calls internally to the Backend service.
2.  **Backend (Node.js + Express)**: Receives HTTP requests from the frontend or stress tests. It adds tasks to the Redis queue and saves the initial state. 
3.  **Worker (Node.js)**: A background processor. It continuously polls the Redis queue, simulates heavy CPU processing, and marks tasks as completed.
4.  **Redis**: The message broker and temporary state store. It uses a **PersistentVolumeClaim (PVC)** so that if the Redis pod crashes, the queue data survives.
5.  **Prometheus & Grafana**: The Observability stack. Prometheus reaches out to every single pod to collect custom metrics (CPU usage, task processing rates). Grafana reads this data to build the dashboard.

### 📈 Horizontal Pod Autoscaling (HPA)
The true power of Kubernetes is **Autoscaling**. 
- The **Metrics Server** constantly monitors the CPU of every pod.
- We have instructed the HPA to maintain a target of **5% CPU**.
- If a flood of tasks arrives, the Backend and Worker CPU spikes. The HPA notices this spike and automatically provisions new duplicate pods to share the load. Once the queue is empty and the CPU drops, the HPA terminates the extra pods to save resources.

### 🚀 Kubernetes Quick Start (Automated)

We have automated the tedious setup process using cross-platform shell scripts.

#### Start the Cluster
```bash
./run-k8s.sh
```
**What this does:**
1. Rebuilds all Docker images locally using multi-stage builds.
2. Applies all YAML files in the `k8s/` directory.
3. Installs the official Kubernetes Metrics Server.
4. Waits for all pods to be healthy.
5. Automatically opens **4 new terminal windows**, establishing port-forwards to your local machine.

#### Access the Services
- **Frontend / UI**: `http://localhost:8080`
- **Backend API**: `http://localhost:5000`
- **Prometheus**: `http://localhost:9090`
- **Grafana**: `http://localhost:3000`

#### Stress Test the Cluster
In your main terminal, run our interactive load tester:
```bash
node stress.js
```
It will ask how many tasks to send. Type a number (e.g., `1000`) and hit Enter to watch the autoscaler spin up new pods!

#### Stop the Cluster
```bash
./stop-k8s.sh
```
This serves as a "Kill Switch", completely tearing down all Deployments, Services, PVCs, and the Metrics Server.

---

## 🔍 Command Line Reference (No Docker Desktop Needed)

You do not need a GUI to manage your cluster. Use these native `kubectl` commands to inspect your environment.

### 📦 See Running Pods
```bash
# View all pods in the default namespace
kubectl get pods

# View pods with extra details (like IP addresses and which Node they run on)
kubectl get pods -o wide

# Watch pods update in real-time (Press Ctrl+C to stop)
kubectl get pods -w
```

### 🚦 See Auto-Scaling (HPA)
```bash
# View the current CPU usage vs the target, and active replicas
kubectl get hpa

# Watch the HPA scale up and down in real-time
kubectl get hpa -w
```

### 🕸️ See Networking (Services)
```bash
# View all active internal network load balancers
kubectl get services
```

### 📜 Check Logs & Debug
```bash
# View the logs for a specific pod (replace with your pod's exact name)
kubectl logs backend-dd778b69d-2njjz

# View the logs for ALL backend pods combined
kubectl logs -l app=backend

# Find out WHY a pod is failing or crashing
kubectl describe pod worker-fc95fc86b-tlh7g
```

### 🌍 Cluster Health
```bash
# Check if your cluster (e.g., kind) is online and responding
kubectl cluster-info

# Check the health of the underlying nodes
kubectl get nodes
```

<br><br>
<img src="https://capsule-render.vercel.app/api?type=soft&color=gradient&height=10&section=header" width="1080" align="center"/>

```
Developed as part of the Containerization Tool project.

- Om Ji Rao - 1NH23CS176
- Pratham Reet - 1NH23CS191
```

<img src="https://capsule-render.vercel.app/api?type=soft&color=gradient&height=10&section=header" width="1080" align="center"/>