Viewed dashboard.json:1-10

I will list the contents of the `docs/assets` directory to see what images/files are already there. This will allow me to create an exact, concise mapping of which file corresponds to which placeholder in your final report.

Listed directory assets

Here is the exact, concise mapping of your 14 files in `docs/assets/` to their designated placeholders in `new-report.md`. 

You can use this as a reference checklist to copy-paste the images into your Word document:

### 📸 Screenshot Mapping Table

| No.    | Placeholder in Report                                                                         | File in `docs/assets/`                                                     | Purpose & Context                                                            |
| :----- | :-------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------- | :--------------------------------------------------------------------------- |
| **1**  | **Chapter 3.1**<br>`*[ Insert Screenshot: System Architecture Diagram ]*`                     | *(Use Mermaid)*                                                            | Paste the generated **Mermaid.js flowchart** from Chapter 3.1 directly here. |
| **2**  | **Chapter 3.3**<br>`*[ Insert Screenshot: Docker Compose Services Running... ]*`              | **`Docker Compose.png`** <br>*(or `docker desktop container.png`)*         | Shows local Docker Compose services and their ports running smoothly.        |
| **3**  | **Chapter 3.5**<br>`*[ Insert Screenshot: Kubernetes Dashboard or 'kubectl get all'... ]*`    | **`kubectl getall.png`**                                                   | Output of the cluster state showing active Deployments, Services, and HPAs.  |
| **4**  | **Chapter 4.3**<br>`*[ Insert Screenshot: TaskFlow Frontend UI showing tasks... ]*`           | **`frontend ui.png`**                                                      | Dark-themed browser UI with active completed/pending task status pills.      |
| **5**  | **Chapter 4.4**<br>`*[ Insert Screenshot: Prometheus Targets page... ]*`                      | **`prometeus targets.png`** <br>*(or `promethus kubernetes endpoits.png`)* | Browser view of scraped active targets discovered by K8s SD.                 |
| **6**  | **Chapter 4.5**<br>`*[ Insert Screenshot: Terminal running stress.js... ]*`                   | **`stress test.png`**                                                      | Command prompt firing task batches from the interactive script.              |
| **7**  | **Chapter 5.1**<br>`*[ Insert Screenshot: PowerShell terminal running run-k8s.ps1... ]*`      | **`kubernete cli start.png`**                                              | PowerShell window building images and starting K8s deployments.              |
| **8**  | **Chapter 5.2** & **6.4**<br>`*[ Insert Screenshot: 'kubectl get hpa -w' terminal... ]*`      | **`HPA watch.png`**                                                        | Live watch feed of pod replicas scaling from 1 up to 10.                     |
| **9**  | **Chapter 5.4**<br>`*[ Insert Screenshot: 'kubectl describe pod' output... ]*`                | **`kubernetes cluster descktop.png`**                                      | Resource details showcasing health probes (Liveness/Readiness).              |
| **10** | **Chapter 5.6** & **7.3**<br>`*[ Insert Screenshot: Grafana dashboard during peak load... ]*` | **`kubernetes grafana.png`**                                               | Grafana showing all active panels (Active Pods, CPU load, Queue Pressure).   |
| **11** | **Chapter 6.5**<br>`*[ Insert Screenshot: 'kubectl get pods -w' showing deletion... ]*`       | **`kubernets cleanup.png`**                                                | Shows pod transition states and cleanups during self-healing.                |
| **12** | **Chapter 7.2**<br>`*[ Insert Screenshot: Grafana "Task Throughput" panel... ]*`              | **`docker grafana.png`**                                                   | Zoomed-in chart highlighting the scaling throughput increase.                |
| **13** | **Chapter 7.4**<br>`*[ Insert Screenshot: GitHub Actions pipeline run... ]*`                  | **`cicd.png`**                                                             | Complete green GitHub Actions CI pipeline execution run.                     |