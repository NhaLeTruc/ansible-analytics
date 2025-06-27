############################################
## Kafka
############################################
module "Kafka" {
  source = "../modules/vm"
  for_each = {
    for idx, vm in var.Kafka : idx + 1 => vm
  }

  hostname    = "Kafka-${each.key}"
  vmid        = each.value.id
  tags        = var.tags
  target_node = var.target_node

  clone_template_id = each.value.template_id
  onboot            = var.onboot
  started           = var.started

  cores   = each.value.cores
  sockets = each.value.sockets
  memory  = each.value.memory

  # disk_size      = each.value.disk_size
  disk_datastore = var.disk_datastore

  ip_address = each.value.ip_address
  ip_gateway = var.ip_gateway

  # Template already have ssh key. Ajust as needed
  # ssh_user        = var.ssh_user
  # ssh_public_keys = [file(var.ssh_public_key_file)]
}

############################################
## Airflow
############################################
module "Airflow" {
  source = "../modules/vm"
  for_each = {
    for idx, vm in var.Airflow : idx + 1 => vm
  }

  hostname    = "Airflow-${each.key}"
  vmid        = each.value.id
  tags        = var.tags
  target_node = var.target_node

  clone_template_id = each.value.template_id
  onboot            = var.onboot
  started           = var.started

  cores   = each.value.cores
  sockets = each.value.sockets
  memory  = each.value.memory

  # disk_size      = each.value.disk_size
  disk_datastore = var.disk_datastore

  ip_address = each.value.ip_address
  ip_gateway = var.ip_gateway

  # Template already have ssh key. Ajust as needed
  # ssh_user        = var.ssh_user
  # ssh_public_keys = [file(var.ssh_public_key_file)]
}

############################################
## Spark
############################################
module "Spark" {
  source = "../modules/vm"
  for_each = {
    for idx, vm in var.Spark : idx + 1 => vm
  }

  hostname    = "Spark-${each.key}"
  vmid        = each.value.id
  tags        = var.tags
  target_node = var.target_node

  clone_template_id = each.value.template_id
  onboot            = var.onboot
  started           = var.started

  cores   = each.value.cores
  sockets = each.value.sockets
  memory  = each.value.memory

  # disk_size      = each.value.disk_size
  disk_datastore = var.disk_datastore

  ip_address = each.value.ip_address
  ip_gateway = var.ip_gateway

  # Template already have ssh key. Ajust as needed
  # ssh_user        = var.ssh_user
  # ssh_public_keys = [file(var.ssh_public_key_file)]
}

############################################
## Flink
############################################
module "Flink" {
  source = "../modules/vm"
  for_each = {
    for idx, vm in var.Flink : idx + 1 => vm
  }

  hostname    = "Flink-${each.key}"
  vmid        = each.value.id
  tags        = var.tags
  target_node = var.target_node

  clone_template_id = each.value.template_id
  onboot            = var.onboot
  started           = var.started

  cores   = each.value.cores
  sockets = each.value.sockets
  memory  = each.value.memory

  # disk_size      = each.value.disk_size
  disk_datastore = var.disk_datastore

  ip_address = each.value.ip_address
  ip_gateway = var.ip_gateway

  # Template already have ssh key. Ajust as needed
  # ssh_user        = var.ssh_user
  # ssh_public_keys = [file(var.ssh_public_key_file)]
}

############################################
## SparkStreaming
############################################
module "SparkStreaming" {
  source = "../modules/vm"
  for_each = {
    for idx, vm in var.SparkStreaming : idx + 1 => vm
  }

  hostname    = "SparkStreaming-${each.key}"
  vmid        = each.value.id
  tags        = var.tags
  target_node = var.target_node

  clone_template_id = each.value.template_id
  onboot            = var.onboot
  started           = var.started

  cores   = each.value.cores
  sockets = each.value.sockets
  memory  = each.value.memory

  # disk_size      = each.value.disk_size
  disk_datastore = var.disk_datastore

  ip_address = each.value.ip_address
  ip_gateway = var.ip_gateway

  # Template already have ssh key. Ajust as needed
  # ssh_user        = var.ssh_user
  # ssh_public_keys = [file(var.ssh_public_key_file)]
}

############################################
## Minio
############################################
module "Minio" {
  source = "../modules/vm"
  for_each = {
    for idx, vm in var.Minio : idx + 1 => vm
  }

  hostname    = "Minio-${each.key}"
  vmid        = each.value.id
  tags        = var.tags
  target_node = var.target_node

  clone_template_id = each.value.template_id
  onboot            = var.onboot
  started           = var.started

  cores   = each.value.cores
  sockets = each.value.sockets
  memory  = each.value.memory

  # disk_size      = each.value.disk_size
  disk_datastore = var.disk_datastore

  ip_address = each.value.ip_address
  ip_gateway = var.ip_gateway

  # Template already have ssh key. Ajust as needed
  # ssh_user        = var.ssh_user
  # ssh_public_keys = [file(var.ssh_public_key_file)]
}

############################################
## ansible_inventory
############################################
resource "local_file" "tf_ansible_inventory_file" {
  depends_on = [
    module.masters,
    module.workers,
    module.balancers,
    module.pgbackrest
  ]

  content         = <<-EOF
[Kafka]
%{for vm in var.Kafka~}
${split("/", vm.ip_address)[0]}
%{endfor~}

[Airflow]
%{for vm in var.Airflow~}
${split("/", vm.ip_address)[0]}
%{endfor~}

[Flink]
%{for vm in var.Flink~}
${split("/", vm.ip_address)[0]}
%{endfor~}

[Spark]
%{for vm in var.Spark~}
${split("/", vm.ip_address)[0]}
%{endfor~}

[SparkStreaming]
%{for vm in var.SparkStreaming~}
${split("/", vm.ip_address)[0]}
%{endfor~}

[Minio]
%{for vm in var.Minio~}
${split("/", vm.ip_address)[0]}
%{endfor~}

[streaming_cluster:children]
Flink
SparkStreaming

EOF
  filename        = "../../ansible/tf_ansible_inventory"
  file_permission = "0644"
}
