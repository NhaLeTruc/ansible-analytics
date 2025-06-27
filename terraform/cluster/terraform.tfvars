# API proxmox
proxmox_api_url ="https://192.168.1.9:8006/"
proxmox_api_token_id = "terraform@pve!infratf=a4894a3b-3331-41b0-871a-fb4963db2ac0"

# template_id = 905
# new_vm_id = 500
tags = ["test"]

control_ip_address = "192.168.1.5/24"
ip_gateway = "192.168.1.1"
disk_datastore = "local-lvm"

# ssh_user = "debian"
# ssh_public_key_file = "/root/.ssh/id_rsa.pub"

onboot = false
started = true
target_node = "pve"

# Kafka
# Airflow
# Flink
# Spark
# SparkStreaming
# Minio
# 11 servers need 800GB disk space.
Kafka = [{
  cores = 2
  # disk_size = 110
  template_id = 907
  id = 200
  ip_address = "192.168.1.11/24"
  memory = 5120
  name = "main-node"
  sockets = 2
}]

Airflow = [
  {
    cores = 2
    # disk_size = 110
    template_id = 907
    id = 201
    ip_address = "192.168.1.12/24"
    memory = 5120
    name = "replica-node"
    sockets = 2
  },
  {
    cores = 2
    # disk_size = 110
    template_id = 907
    id = 202
    ip_address = "192.168.1.13/24"
    memory = 5120
    name = "replica-node"
    sockets = 2
  },
  {
    cores = 2
    # disk_size = 110
    template_id = 907
    id = 203
    ip_address = "192.168.1.14/24"
    memory = 5120
    name = "replica-node"
    sockets = 2
  },
  {
    cores = 2
    # disk_size = 110
    template_id = 907
    id = 204
    ip_address = "192.168.1.15/24"
    memory = 5120
    name = "replica-node"
    sockets = 2
  }
]

Flink = [
  {
    cores = 2
    # disk_size = 20
    template_id = 906
    id = 205
    ip_address = "192.168.1.16/24"
    memory = 5120
    name = "dcs-node"
    sockets = 2
  },
  {
    cores = 2
    # disk_size = 20
    template_id = 906
    id = 206
    ip_address = "192.168.1.17/24"
    memory = 5120
    name = "dcs-node"
    sockets = 2
  },
  {
    cores = 2
    # disk_size = 20
    template_id = 906
    id = 207
    ip_address = "192.168.1.18/24"
    memory = 5120
    name = "dcs-node"
    sockets = 2
  }
]


Spark = [{
  cores = 2
  # disk_size = 20
  template_id = 905
  id = 208
  ip_address = "192.168.1.19/24"
  memory = 5120
  name = "proxy-node"
  sockets = 2
}]

SparkStreaming = [{
  cores = 2
  # disk_size = 110
  template_id = 907
  id = 209
  ip_address = "192.168.1.20/24"
  memory = 5120
  name = "backup-node"
  sockets = 2
}]

Minio = [{
  cores = 2
  # disk_size = 60
  template_id = 906
  id = 210
  ip_address = "192.168.1.21/24"
  memory = 5120
  name = "monitor-node"
  sockets = 2
}]
