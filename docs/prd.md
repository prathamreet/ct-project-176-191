<img src="https://capsule-render.vercel.app/api?type=soft&color=gradient&height=10&section=header" width="1080" align="center"/>
<br>
<br>

# PRD — TaskFlow (Dockerized Task Queue System)

## 1. Overview

TaskFlow is a minimal task queue system that demonstrates asynchronous processing using a multi-container architecture. Users submit tasks via a web interface. Tasks are queued in Redis, processed by a worker service, and results are stored in SQLite. The system is fully containerized using Docker Compose and includes basic monitoring and CI/CD.

## 2. Objectives

* Demonstrate multi-container architecture using Docker
* Implement async task processing with a queue (Redis)
* Separate concerns across services (API, worker, DB, frontend)
* Provide simple observability via Grafana
* Automate build and run via CI/CD

## 3. Scope

In-scope:

* Task creation and status tracking
* Queue-based processing (Redis)
* Worker service for background execution
* Persistent storage (SQLite)
* Container orchestration (Docker Compose)
* Basic monitoring dashboard (Grafana)

Out-of-scope:

* Authentication/authorization
* Complex UI/UX
* Horizontal scaling / Kubernetes
* Production-grade security

## 4. System Architecture

Components:

* Frontend: UI to create tasks and view status
* Backend API: receives requests, pushes tasks to Redis, reads status
* Redis: message queue
* Worker: consumes queue, processes tasks
* SQLite: stores task results
* Grafana: visualizes metrics

Data Flow:

1. User submits task via frontend
2. Backend pushes task to Redis queue
3. Worker consumes task from Redis
4. Worker processes and writes result to SQLite
5. Frontend fetches task status via backend

## 5. Functional Requirements

* Create Task

  * Input: simple payload (e.g., text/job name)
  * Output: task ID
* View Task Status

  * States: pending, processing, completed
* Background Processing

  * Worker consumes tasks asynchronously
* Data Persistence

  * Store task results in SQLite
* Monitoring

  * Basic metrics (task count, processed tasks)

## 6. Non-Functional Requirements

* Lightweight and fast setup
* Clear container separation
* Deterministic local execution via Docker Compose
* Minimal resource usage
* Simple logs for debugging

## 7. Container Design

Services:

* frontend (React/Next.js)
* backend (Node.js/Express)
* redis (official image)
* worker (Node.js service)
* grafana (official image)
* sqlite (via backend/worker volume)

Dependencies:

* frontend → backend
* backend → redis
* worker → redis, sqlite
* grafana → metrics source

## 8. API Design (Minimal)

* POST /task → create task
* GET /task/:id → get status/result

## 9. Data Model (SQLite)

Table: tasks

* id (string)
* status (pending/processing/completed)
* result (text)
* created_at (timestamp)

## 10. CI/CD

Tool: GitHub Actions

Pipeline:

* Trigger on push
* Build frontend, backend, worker images
* Run docker-compose for validation

## 11. Monitoring

Tool: Grafana

Metrics:

* total tasks
* completed tasks
* queue size (optional)

## 12. Success Criteria

* All services run via single docker-compose command
* Task lifecycle works end-to-end
* Worker processes tasks asynchronously
* Data persists in SQLite
* Basic metrics visible in Grafana

## 13. Timeline (Suggested)

* Day 1: Backend + SQLite
* Day 2: Redis queue + worker
* Day 3: Frontend
* Day 4: Docker + Compose
* Day 5: CI/CD + Monitoring

## 14. Risks

* Redis queue handling bugs
* Worker synchronization issues
* Docker networking misconfiguration

## 15. Deliverables

* Source code (frontend, backend, worker)
* docker-compose.yml
* Dockerfiles
* CI/CD workflow
* Basic documentation

<br>
<img src="https://capsule-render.vercel.app/api?type=soft&color=gradient&height=10&section=header" width="1080" align="center"/>