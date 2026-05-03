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

<br><br>
<img src="https://capsule-render.vercel.app/api?type=soft&color=gradient&height=10&section=header" width="1080" align="center"/>

```
Developed as part of the Containerization Tool project.

- Om Ji Rao - 1NH23CS176
- Pratham Reet - 1NH23CS191
```

<img src="https://capsule-render.vercel.app/api?type=soft&color=gradient&height=10&section=header" width="1080" align="center"/>