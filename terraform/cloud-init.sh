#!/bin/bash

set -euxo pipefail

NODE_EXPORTER_VERSION="${node_exporter_version}"

dnf install -y curl tar firewalld

systemctl enable --now firewalld || true

useradd --no-create-home --shell /bin/false node_exporter || true

curl -fL \
  -o /tmp/node_exporter.tar.gz \
  "https://github.com/prometheus/node_exporter/releases/download/v$${NODE_EXPORTER_VERSION}/node_exporter-$${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"

tar -xzf /tmp/node_exporter.tar.gz -C /tmp
cp "/tmp/node_exporter-$${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter" /usr/local/bin/
chown node_exporter:node_exporter /usr/local/bin/node_exporter

cat <<EOF >/etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now node_exporter

firewall-cmd --permanent --add-port=9100/tcp
firewall-cmd --reload
