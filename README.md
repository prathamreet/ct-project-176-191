<img src="https://capsule-render.vercel.app/api?type=soft&color=gradient&height=10&section=header" width="1080" align="center"/>

> Om Ji Rao (1NH23CS176)  ·  Pratham Reet (1NH23CS191)

<img src="https://capsule-render.vercel.app/api?type=soft&color=gradient&height=10&section=header" width="1080" align="center"/>

# TaskFlow - Scalable Asynchronous Job Engine

TaskFlow is an industry-standard, high-performance asynchronous task processing system built using a decoupled microservices architecture. It demonstrates modern DevOps engineering principles, including horizontal scaling, self-healing infrastructures, dynamic metric scrapers, and automated integration pipelines.

### Core Objectives
1. **Multi-Service Architecture:** Design and implement an asynchronous task queue with separation of concerns across Nginx frontend, Express backend API, Redis message broker, and background workers.
2. **Multi-Stage Containerization:** Containerize all services using optimized multi-stage Docker builds to achieve an 80% package footprint reduction for production environments.
3. **Orchestrated Deployment:** Deploy the complete system on Kubernetes using Horizontal Pod Autoscalers (HPA) for dynamic scaling and Persistent Volume Claims (PVC) for broker state safety.
4. **Cloud-Native Observability:** Establish a production-grade observability pipeline using Prometheus Service Discovery (via Kubernetes RBAC API permissions) and custom Grafana dashboards.
5. **CI/CD Automation:** Automate the build, test, and validation lifecycle using fully integrated GitHub Actions workflows.

```
                  ┌────────────────────────┐
                  │      Frontend UI       │
                  │   (Nginx Web Server)   │
                  └───────────┬────────────┘
                              │ (Reverse Proxy /api/*)
                              ▼
                  ┌────────────────────────┐
                  │    Backend API Core    │  ◄──── [Prometheus Pull]
                  │   (Node.js Express)    │
                  └───────────┬────────────┘
                              │
                    (LPUSH)   ▼   (RPOP)
                  ┌────────────────────────┐
                  │  Redis Message Broker  │
                  │     (Queue & AOF)      │
                  └───────────┬────────────┘
                              │
                              ▼
                  ┌────────────────────────┐
                  │   Background Worker    │  ◄──── [Prometheus Pull]
                  │    (Node.js Engine)    │
                  └────────────────────────┘
```

### Decoupled Core Services
*   **Frontend UI (Nginx):** A high-performance Alpine-based reverse proxy that serves the dark-themed dashboard and forwards API routes cleanly, separating external client paths from internal networks.
*   **Backend API (Express):** Exposes RESTful endpoints for task creation/retrieval and generates dynamic, standard Prometheus metrics from process resource usage and active state.
*   **Worker Engine (Node.js):** Consumes queue jobs using an event-loop-safe non-blocking polling mechanism and updates state in Redis.
*   **Message Broker (Redis):** Manages task lists (`queue` and `all_tasks`) backed by a Persistent Volume Claim using **Append-Only File (AOF)** persistence.


## Key Engineering Highlights

### Docker Multi-Stage Optimization
Both Backend and Worker images implement multi-stage production builds separating builder compilers from lightweight lean runtimes, resulting in an **80% package footprint reduction**:

| Service Container  | Single-Stage Size | Multi-Stage Size | Reduction % | Pull/Startup Time |
| :----------------- | :---------------: | :--------------: | :---------: | :---------------: |
| **Backend Core**   |      913 MB       |    **184 MB**    |  **79.8%**  |  ~45s → **12s**   |
| **Worker Engine**  |      913 MB       |    **184 MB**    |  **79.8%**  |  ~45s → **12s**   |
| **Frontend Proxy** |      24.7 MB      |   **24.7 MB**    | *Baseline*  |       < 3s        |

### Kubernetes Native Elastic Scaling (HPA)
The cluster deploys automated **Horizontal Pod Autoscalers (HPA)** configured with responsive, low limits for demonstrable scaling behavior during workloads:
*   **Worker Auto-Scalability:** Dynamically scales from **1 to 10 replicas** based on target CPU utilization limits.
*   **Backend Auto-Scalability:** Scales from **1 to 5 replicas** dynamically to manage high API traffic.
*   **Performance Metrics:** Handles **580 tasks/sec** at peak capacity with 10 replicas (an **8.9x** throughput increase over single-pod baselines).

### Self-Healing & State Persistence
*   **Probes:** Equipped with custom `livenessProbes` to trigger container restarts on thread blockages and `readinessProbes` to route user traffic only when the Redis network link is active.
*   **Data Integrity:** Redis leverages active AOF logging mapped to a `PersistentVolumeClaim` (PVC), preserving queue states across sudden pod restarts and replacements.

### RBAC Observability Pipeline
*   **Prometheus Service Discovery:** Configured with a Kubernetes `ClusterRole` ServiceAccount to query pod endpoints dynamically via K8s APIs, scraping metrics automatically as HPAs create or terminate replicas.
*   **Grafana Dashboards:** Pre-provisioned dashboards plotting panel statistics for *Active Pods*, *CPU Load*, *Task Throughput*, *Processing Speed*, and *Queue Pressure*.


## Technology Stack

*   **Runtime:** Node.js (v18 LTS), Express, Redis client
*   **Broker:** Redis (Alpine, AOF persistence)
*   **Proxy & Web Server:** Nginx (Alpine)
*   **Orchestration:** Docker Compose (Local Dev) / Kubernetes (Production minikube)
*   **Metrics & Visualization:** Prometheus OSS & Grafana Dashboards
*   **CI/CD:** GitHub Actions (HTMLHint, Compose Linter, Automated Multi-stage builds)


## Project Directory Structure

```
taskflow/
├── docker-compose.yml       # Local multi-container development environment
├── README.md                # System Overview & report summaries
├── .gitignore               # Configured to exclude agent and graph files
├── services/
│   ├── backend/             # Express API & Metrics Server + Multi-stage Dockerfile
│   ├── frontend/            # Dark-theme HTML/CSS UI & Nginx Reverse Proxy Config
│   └── worker/              # Queue processing consumer & Metrics + Multi-stage Dockerfile
├── infra/
│   ├── k8s/                 # Kubernetes YAML configs (Deployments, Services, HPAs, PVCs)
│   └── monitoring/          # Prometheus configuration, RBAC, Grafana dashboards
├── scripts/
│   ├── run-k8s.ps1 / .sh    # Automation deployment scripts (starts, ports, and registers)
│   ├── stop-k8s.ps1 / .sh   # Automation teardown scripts
│   └── stress.js            # Interactive high-concurrency stress testing script
└── .github/workflows/       # GitHub Actions CI pipelines
```


## Quick Start Guide

### 1. Local Container Development (Docker Compose)
Build and spin up the complete local environment in detached mode:
```bash
# Start all services
docker-compose up --build -d

# Verify local running containers
docker-compose ps

# Stop all services
docker-compose down
```

### 2. Kubernetes Orchestration Deployment (minikube / kubectl)
Run the automated powershell/bash pipeline scripts to spin up, build, deploy K8s manifests, install Metrics Servers, and configure local port forwards in one command:
```bash
# Run automated setup
./scripts/run-k8s.sh

# Run interactive load generator to trigger scaling (Input 500 tasks)
node scripts/stress.js

# Teardown local cluster resources
./scripts/stop-k8s.sh
```

---

## Port & Endpoint Reference

| Interface Dashboard        | Service Engine    | Access URL                | Port Type               |
| :------------------------- | :---------------- | :------------------------ | :---------------------- |
| **Frontend Web Dashboard** | Nginx Proxy       | **http://localhost:8080** | LoadBalancer / External |
| **Backend REST API**       | Express Core      | **http://localhost:5000** | ClusterIP / Internal    |
| **Prometheus Targets**     | Metrics Scraper   | **http://localhost:9090** | ClusterIP / Internal    |
| **Grafana Visualizations** | System Dashboards | **http://localhost:3000** | LoadBalancer / External |

---

## CLI Cheat Sheet

```bash
# Verify active pods & services
kubectl get pods -o wide
kubectl get services

# Watch Autoscaling (HPA) live
kubectl get hpa -w

# Check container health and persistent storage mounts
kubectl describe pod backend-<name>
kubectl get pvc

# Aggregate application logs
kubectl logs -l app=backend --tail=100
```
<img src="https://capsule-render.vercel.app/api?type=soft&color=gradient&height=10&section=header" width="1080" align="center"/>


*   **Interactive Code Dependency Graph:** [TaskFlow System Dependency Graph](https://exquisite-marzipan-5c18ba.netlify.app/graph.html)
*   **Interactive Codebase Call-Flow Map:** [TaskFlow Dynamic Call-Flow Diagrams](https://exquisite-marzipan-5c18ba.netlify.app/ctmp-callflow.html)

<img src="https://capsule-render.vercel.app/api?type=soft&color=gradient&height=10&section=header" width="1080" align="center"/>
