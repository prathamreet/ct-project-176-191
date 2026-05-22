# Graph Report - ctmp  (2026-05-22)

## Corpus Check
- 6 files · ~3,016 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 78 nodes · 76 edges · 14 communities (9 shown, 5 thin omitted)
- Extraction: 84% EXTRACTED · 16% INFERRED · 0% AMBIGUOUS · INFERRED: 12 edges (avg confidence: 0.89)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `9d0529dd`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- [[_COMMUNITY_Backend Server Core|Backend Server Core]]
- [[_COMMUNITY_Task Workflow|Task Workflow]]
- [[_COMMUNITY_Worker Core|Worker Core]]
- [[_COMMUNITY_Docker Compose Services|Docker Compose Services]]
- [[_COMMUNITY_Observability Architecture|Observability Architecture]]
- [[_COMMUNITY_Monitoring Stack|Monitoring Stack]]
- [[_COMMUNITY_Prometheus Metrics|Prometheus Metrics]]
- [[_COMMUNITY_Autoscaling Features|Autoscaling Features]]
- [[_COMMUNITY_Database System|Database System]]
- [[_COMMUNITY_Grafana Dashboards|Grafana Dashboards]]
- [[_COMMUNITY_Community 11|Community 11]]
- [[_COMMUNITY_Community 12|Community 12]]
- [[_COMMUNITY_Community 13|Community 13]]

## God Nodes (most connected - your core abstractions)
1. `PRD — TaskFlow (Dockerized Task Queue System)` - 16 edges
2. `TaskFlow - Scalable Job Processing Engine` - 5 edges
3. `TaskFlow System` - 5 edges
4. `redis` - 3 edges
5. `client` - 3 edges
6. `run` - 3 edges
7. `Redis Service` - 3 edges
8. `Backend Service` - 3 edges
9. `Backend Service` - 3 edges
10. `Worker Service` - 3 edges

## Surprising Connections (you probably didn't know these)
- `POST /task` --calls--> `addTask`  [INFERRED]
  backend/server.js → frontend/index.html
- `GET /metrics` --calls--> `Prometheus Config`  [INFERRED]
  backend/server.js → monitoring/prometheus.yml
- `run` --implements--> `Worker Service`  [INFERRED]
  worker/worker.js → README.md
- `run` --shares_data_with--> `Queue/DB (Redis)`  [INFERRED]
  worker/worker.js → README.md
- `POST /task` --shares_data_with--> `run`  [INFERRED]
  backend/server.js → worker/worker.js

## Hyperedges (group relationships)
- **TaskFlow Architecture Components** — readme_frontend, readme_backend, readme_worker, readme_redis, readme_prometheus, readme_grafana [EXTRACTED 1.00]

## Communities (14 total, 5 thin omitted)

### Community 0 - "Backend Server Core"
Cohesion: 0.12
Nodes (16): 10. CI/CD, 11. Monitoring, 12. Success Criteria, 13. Timeline (Suggested), 14. Risks, 15. Deliverables, 1. Overview, 2. Objectives (+8 more)

### Community 1 - "Task Workflow"
Cohesion: 0.33
Nodes (8): app, client, cors, cpu, express, id, redis, tasks

### Community 2 - "Worker Core"
Cohesion: 0.27
Nodes (6): app, client, cpu, express, redis, run()

### Community 3 - "Docker Compose Services"
Cohesion: 0.22
Nodes (8): code:bash (docker-compose up --build -d), code:bash (./scripts/run-k8s.sh), code:bash (# Pods), Docker - Quick Start, kubectl Reference, Kubernetes - Quick Start, Stack, TaskFlow - Scalable Job Processing Engine

### Community 4 - "Observability Architecture"
Cohesion: 0.22
Nodes (9): Backend Service, Frontend Service, Redis Service, Worker Service, Kubernetes Transition, Observability, Service Discovery, TaskFlow System (+1 more)

### Community 5 - "Monitoring Stack"
Cohesion: 0.32
Nodes (8): addTask, Asynchronous Pattern, Backend Service, Metrics (Prometheus), Queue/DB (Redis), Worker Service, POST /task, run

### Community 6 - "Prometheus Metrics"
Cohesion: 0.4
Nodes (3): http, readline, rl

### Community 7 - "Autoscaling Features"
Cohesion: 0.67
Nodes (3): Grafana Service, Prometheus Service, Grafana Datasource

## Knowledge Gaps
- **42 isolated node(s):** `http`, `readline`, `rl`, `cpu`, `express` (+37 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **5 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `TaskFlow System` connect `Observability Architecture` to `Monitoring Stack`?**
  _High betweenness centrality (0.028) - this node is a cross-community bridge._
- **Why does `Asynchronous Pattern` connect `Monitoring Stack` to `Observability Architecture`?**
  _High betweenness centrality (0.022) - this node is a cross-community bridge._
- **Are the 5 inferred relationships involving `TaskFlow System` (e.g. with `Redis Service` and `Zero-Volume Orchestration`) actually correct?**
  _`TaskFlow System` has 5 INFERRED edges - model-reasoned connections that need verification._
- **What connects `http`, `readline`, `rl` to the rest of the system?**
  _42 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Backend Server Core` be split into smaller, more focused modules?**
  _Cohesion score 0.12 - nodes in this community are weakly interconnected._