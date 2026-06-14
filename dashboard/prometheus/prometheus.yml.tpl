global:
  scrape_interval: 15s

scrape_configs:
  - job_name: "node_exporter"

    static_configs:
%{ for target in targets ~}
      - targets:
          - "${target.public_ip}:9100"
        labels:
          instance_name: "${target.name}"
          private_ip: "${target.private_ip}"
          oci_instance_id: "${target.id}"
%{ endfor ~}
