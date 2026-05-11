# Graph Report - .  (2026-05-11)

## Corpus Check
- Corpus is ~2,080 words - fits in a single context window. You may not need a graph.

## Summary
- 28 nodes · 20 edges · 8 communities (4 shown, 4 thin omitted)
- Extraction: 70% EXTRACTED · 30% INFERRED · 0% AMBIGUOUS · INFERRED: 6 edges (avg confidence: 0.9)
- Token cost: 2,000 input · 500 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Backend App Setup|Backend App Setup]]
- [[_COMMUNITY_System Architecture|System Architecture]]
- [[_COMMUNITY_Worker Processing|Worker Processing]]
- [[_COMMUNITY_Task Processing Flow|Task Processing Flow]]
- [[_COMMUNITY_Monitoring Config|Monitoring Config]]
- [[_COMMUNITY_Metrics Export|Metrics Export]]
- [[_COMMUNITY_Kubernetes Features|Kubernetes Features]]
- [[_COMMUNITY_Storage Docs|Storage Docs]]

## God Nodes (most connected - your core abstractions)
1. `Redis Service` - 3 edges
2. `Backend Service` - 3 edges
3. `POST /task` - 2 edges
4. `Prometheus Service` - 2 edges
5. `express` - 1 edges
6. `redis` - 1 edges
7. `cors` - 1 edges
8. `app` - 1 edges
9. `client` - 1 edges
10. `id` - 1 edges

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

## Communities (8 total, 4 thin omitted)

### Community 0 - "Backend App Setup"
Cohesion: 0.25
Nodes (7): app, client, cors, express, id, redis, tasks

### Community 1 - "System Architecture"
Cohesion: 0.33
Nodes (6): Backend Service, Frontend Service, Redis Service, Worker Service, Kubernetes Transition, TaskFlow

### Community 3 - "Task Processing Flow"
Cohesion: 0.67
Nodes (3): addTask, POST /task, Worker Process Loop

### Community 4 - "Monitoring Config"
Cohesion: 0.67
Nodes (3): Grafana Service, Prometheus Service, Grafana Datasource

## Knowledge Gaps
- **21 isolated node(s):** `express`, `redis`, `cors`, `app`, `client` (+16 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Are the 2 inferred relationships involving `POST /task` (e.g. with `addTask` and `Worker Process Loop`) actually correct?**
  _`POST /task` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `express`, `redis`, `cors` to the rest of the system?**
  _21 weakly-connected nodes found - possible documentation gaps or missing edges._