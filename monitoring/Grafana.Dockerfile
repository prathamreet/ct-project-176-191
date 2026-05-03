FROM grafana/grafana
COPY ./monitoring/grafana-datasource.yml /etc/grafana/provisioning/datasources/datasource.yml
