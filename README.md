# Ansible Roles for Analytic Infrastructure Stack

This repo compose ansible roles for Kafka; Flink; Airflow; and Spark.

```bash
# Deploy analytics stack
ansible-playbook deploy_analytics.yml

# Start zookeeper server and list kafka topics
bin/zookeeper-server-start.sh config/zookeeper.properties

bin/kafka-topics.sh --list --zookeeper localhost:2181

bin/kafka-topics.sh --zookeeper localhost:2181 --describe --topic <TOPIC-NAME>

# Check service
systemctl list-unit-files --type=service | grep kafka
```
