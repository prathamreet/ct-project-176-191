FROM prom/prometheus
COPY ./infra/monitoring/prometheus.yml /etc/prometheus/prometheus.yml
