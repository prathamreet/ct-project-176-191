FROM grafana/grafana
COPY ./infra/monitoring/grafana-datasource.yml /etc/grafana/provisioning/datasources/datasource.yml
