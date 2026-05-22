# Graph Report - .  (2026-05-22)

## Corpus Check
- Corpus is ~2,080 words - fits in a single context window. You may not need a graph.

## Summary
- 39 nodes · 34 edges · 11 communities (6 shown, 5 thin omitted)
- Extraction: 65% EXTRACTED · 35% INFERRED · 0% AMBIGUOUS · INFERRED: 12 edges (avg confidence: 0.89)
- Token cost: 0 input · 0 output

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
- [[_COMMUNITY_Frontend UI|Frontend UI]]
- [[_COMMUNITY_Grafana Dashboards|Grafana Dashboards]]

## God Nodes (most connected - your core abstractions)
1. `TaskFlow System` - 5 edges
2. `run` - 3 edges
3. `Redis Service` - 3 edges
4. `Backend Service` - 3 edges
5. `Backend Service` - 3 edges
6. `Worker Service` - 3 edges
7. `Queue/DB (Redis)` - 3 edges
8. `Asynchronous Pattern` - 3 edges
9. `redis` - 2 edges
10. `client` - 2 edges

## Surprising Connections (you probably didn't know these)
- `POST /task` --calls--> `addTask`  [INFERRED]
  backend/server.js → frontend/index.html
- `GET /metrics` --calls--> `Prometheus Config`  [INFERRED]
  backend/server.js → monitoring/prometheus.yml
- `run` --implements--> `Worker Service`  [INFERRED]
  worker/worker.js → README.md
- `run` --shares_data_with--> `Queue/DB (Redis)`  [INFERRED]
  worker/worker.js → README.md
- `Redis Service` --conceptually_related_to--> `TaskFlow System`  [INFERRED]
  docker-compose.yml → README.md

## Hyperedges (group relationships)
- **TaskFlow Architecture Components** — readme_frontend, readme_backend, readme_worker, readme_redis, readme_prometheus, readme_grafana [EXTRACTED 1.00]

## Communities (11 total, 5 thin omitted)

### Community 0 - "Backend Server Core"
Cohesion: 0.25
Nodes (7): app, client, cors, express, id, redis, tasks

### Community 1 - "Task Workflow"
Cohesion: 0.32
Nodes (8): addTask, Asynchronous Pattern, Backend Service, Metrics (Prometheus), Queue/DB (Redis), Worker Service, POST /task, run

### Community 2 - "Worker Core"
Cohesion: 0.6
Nodes (3): client, redis, run()

### Community 3 - "Docker Compose Services"
Cohesion: 0.4
Nodes (5): Backend Service, Frontend Service, Redis Service, Worker Service, Kubernetes Transition

### Community 4 - "Observability Architecture"
Cohesion: 0.5
Nodes (4): Observability, Service Discovery, TaskFlow System, Zero-Volume Orchestration

### Community 5 - "Monitoring Stack"
Cohesion: 0.67
Nodes (3): Grafana Service, Prometheus Service, Grafana Datasource

## Knowledge Gaps
- **23 isolated node(s):** `express`, `redis`, `cors`, `app`, `client` (+18 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **5 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `TaskFlow System` connect `Observability Architecture` to `Task Workflow`, `Docker Compose Services`?**
  _High betweenness centrality (0.117) - this node is a cross-community bridge._
- **Why does `Asynchronous Pattern` connect `Task Workflow` to `Observability Architecture`?**
  _High betweenness centrality (0.091) - this node is a cross-community bridge._
- **Why does `Redis Service` connect `Docker Compose Services` to `Observability Architecture`?**
  _High betweenness centrality (0.073) - this node is a cross-community bridge._
- **Are the 5 inferred relationships involving `TaskFlow System` (e.g. with `Redis Service` and `Zero-Volume Orchestration`) actually correct?**
  _`TaskFlow System` has 5 INFERRED edges - model-reasoned connections that need verification._
- **Are the 3 inferred relationships involving `run` (e.g. with `POST /task` and `Worker Service`) actually correct?**
  _`run` has 3 INFERRED edges - model-reasoned connections that need verification._
- **What connects `express`, `redis`, `cors` to the rest of the system?**
  _23 weakly-connected nodes found - possible documentation gaps or missing edges._