# Graph Report - ctmp  (2026-05-17)

## Corpus Check
- 6 files · ~3,646 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 87 nodes · 76 edges · 14 communities (11 shown, 3 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 6 edges (avg confidence: 0.9)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `b283316c`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- [[_COMMUNITY_Backend App Setup|Backend App Setup]]
- [[_COMMUNITY_System Architecture|System Architecture]]
- [[_COMMUNITY_Worker Processing|Worker Processing]]
- [[_COMMUNITY_Task Processing Flow|Task Processing Flow]]
- [[_COMMUNITY_Monitoring Config|Monitoring Config]]
- [[_COMMUNITY_Metrics Export|Metrics Export]]
- [[_COMMUNITY_Kubernetes Features|Kubernetes Features]]
- [[_COMMUNITY_Storage Docs|Storage Docs]]
- [[_COMMUNITY_Community 8|Community 8]]
- [[_COMMUNITY_Community 9|Community 9]]
- [[_COMMUNITY_Community 10|Community 10]]
- [[_COMMUNITY_Community 12|Community 12]]
- [[_COMMUNITY_Community 13|Community 13]]

## God Nodes (most connected - your core abstractions)
1. `PRD — TaskFlow (Dockerized Task Queue System)` - 16 edges
2. `TaskFlow - Asynchronous Task Queue System` - 7 edges
3. `🔍 Command Line Reference (No Docker Desktop Needed)` - 6 edges
4. `🚀 Kubernetes Quick Start (Automated)` - 5 edges
5. `🚢 Kubernetes Orchestration` - 4 edges
6. `Quick Start` - 3 edges
7. `🌍 Cluster Health` - 3 edges
8. `Redis Service` - 3 edges
9. `Backend Service` - 3 edges
10. `Project Structure` - 2 edges

## Surprising Connections (you probably didn't know these)
- `addTask` --calls--> `POST /task`  [INFERRED]
  frontend/index.html → backend/server.js
- `Prometheus Config` --calls--> `GET /metrics`  [INFERRED]
  monitoring/prometheus.yml → backend/server.js
- `POST /task` --shares_data_with--> `Worker Process Loop`  [INFERRED]
  backend/server.js → worker/worker.js
- `TaskFlow` --conceptually_related_to--> `Redis Service`  [INFERRED]
  README.md → docker-compose.yml
- `Kubernetes Transition` --conceptually_related_to--> `Backend Service`  [INFERRED]
  docs/feat.md → docker-compose.yml

## Hyperedges (group relationships)
- **TaskFlow Core System** — dockercompose_frontend, dockercompose_backend, dockercompose_worker, dockercompose_redis [EXTRACTED 1.00]

## Communities (14 total, 3 thin omitted)

### Community 0 - "Backend App Setup"
Cohesion: 0.12
Nodes (16): 10. CI/CD, 11. Monitoring, 12. Success Criteria, 13. Timeline (Suggested), 14. Risks, 15. Deliverables, 1. Overview, 2. Objectives (+8 more)

### Community 1 - "System Architecture"
Cohesion: 0.17
Nodes (12): 📜 Check Logs & Debug, 🌍 Cluster Health, code:bash (# Check if your cluster (e.g., kind) is online and respondin), code:block11 (Developed as part of the Containerization Tool project.), code:bash (# View all pods in the default namespace), code:bash (# View the current CPU usage vs the target, and active repli), code:bash (# View all active internal network load balancers), code:bash (# View the logs for a specific pod (replace with your pod's ) (+4 more)

### Community 2 - "Worker Processing"
Cohesion: 0.2
Nodes (9): Architecture & Services, code:text (├── backend/      # API Server), code:bash (docker-compose up --build -d), code:bash (./run-k8s.sh), Key Technical Concepts, Project Structure, Quick Start, Start the Cluster (+1 more)

### Community 3 - "Task Processing Flow"
Cohesion: 0.22
Nodes (8): app, client, cors, cpu, express, id, redis, tasks

### Community 4 - "Monitoring Config"
Cohesion: 0.22
Nodes (9): Access the Services, 🏗️ Architecture & Components, code:bash (node stress.js), code:bash (./stop-k8s.sh), 📈 Horizontal Pod Autoscaling (HPA), 🚢 Kubernetes Orchestration, 🚀 Kubernetes Quick Start (Automated), Stop the Cluster (+1 more)

### Community 5 - "Metrics Export"
Cohesion: 0.25
Nodes (5): app, client, cpu, express, redis

### Community 6 - "Kubernetes Features"
Cohesion: 0.33
Nodes (6): Backend Service, Frontend Service, Redis Service, Worker Service, Kubernetes Transition, TaskFlow

### Community 7 - "Storage Docs"
Cohesion: 0.4
Nodes (3): http, readline, rl

### Community 8 - "Community 8"
Cohesion: 0.67
Nodes (3): addTask, POST /task, Worker Process Loop

### Community 9 - "Community 9"
Cohesion: 0.67
Nodes (3): Grafana Service, Prometheus Service, Grafana Datasource

## Knowledge Gaps
- **58 isolated node(s):** `http`, `readline`, `rl`, `express`, `redis` (+53 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **3 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `TaskFlow - Asynchronous Task Queue System` connect `Worker Processing` to `System Architecture`, `Monitoring Config`?**
  _High betweenness centrality (0.083) - this node is a cross-community bridge._
- **Why does `🔍 Command Line Reference (No Docker Desktop Needed)` connect `System Architecture` to `Worker Processing`?**
  _High betweenness centrality (0.070) - this node is a cross-community bridge._
- **Why does `🚢 Kubernetes Orchestration` connect `Monitoring Config` to `Worker Processing`?**
  _High betweenness centrality (0.049) - this node is a cross-community bridge._
- **What connects `http`, `readline`, `rl` to the rest of the system?**
  _58 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Backend App Setup` be split into smaller, more focused modules?**
  _Cohesion score 0.12 - nodes in this community are weakly interconnected._