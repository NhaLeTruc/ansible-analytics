# Ansible Role to Install and Configure Kafka in KRaft Mode

To configure topics/partitions/ACLs and stuff on already deployed Kafka
cluster use [Kafka-admin Ansible modules](https://galaxy.ansible.com/ui/standalone/roles/StephenSorriaux/kafka-admin/documentation)

## Variables

The following variables must be defined:

- `kafka_node_id` must be set for each node via host_vars
- `kafka_brokers` and `kafka_kraft_controllers` subgroups must be present in
  inventory file

The rest of the variables are optional and have [default values](defaults/main.yml)

### Sample Inventory section

```yaml
kafka_cluster:
  children:
    kafka_brokers:
      hosts:
        kafka-sockshop-a-1-broker:
          kafka_node_id: 1
          ansible_host: 172.31.0.36
        kafka-sockshop-b-1-broker:
          kafka_node_id: 2
          ansible_host: 172.31.16.26
        kafka-sockshop-c-1-broker:
          kafka_node_id: 3
          ansible_host: 172.31.32.35
    kafka_kraft_controllers:
      hosts:
        kafka-sockshop-a-1-controller:
          kafka_node_id: 4
          ansible_host: 172.31.0.37
        kafka-sockshop-b-1-controller:
          kafka_node_id: 5
          ansible_host: 172.31.16.27
        kafka-sockshop-c-1-controller:
          kafka_node_id: 6
          ansible_host: 172.31.32.36
```

## Example Playbook

```yaml
- name: Configure Kafka
  hosts: kafka_cluster
  become: true
  tasks:
    - name: Include Kafka Role
      ansible.builtin.include_role:
        name: kafka
      tags:
        - kafka_preflight
        - kafka_preflight_java
        - kafka_preflight_packages
        - kafka_install
        - kafka_configure
        - kafka_configure_kraft
        - kafka_configure_storage
        - kafka_configure_systemd
        - kafka_check
        - kafka_check_service
        - kafka_check_quorum
        - kafka_check_commands
```

> Full list of tags is provided here. You can drop the once you don't need
> or all of them if you want to run the full role

## Role Structure
