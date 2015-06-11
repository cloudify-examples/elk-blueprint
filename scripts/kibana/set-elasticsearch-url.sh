#!/bin/bash

set -e
ctx logger info  "Post Install kibana"
#ctx source instance runtime_properties elasticsearch_ip_address $(ctx target instance host_ip)
ctx source instance runtime_properties elasticsearch_port $(ctx target node properties port)
ELASTIC_IP=$(ctx target instance runtime_properties elasticsearch_ip_address)
ctx logger info  "Elasticsearch IP is ${ELASTIC_IP}"


#update the kibana.yml to the elasticsearch IP
sudo sed -i -e "s#http://localhost:9200#http://${ELASTIC_IP}:9200#g" /opt/kibana/config/kibana.yml
#sudo stop kibana
sudo start kibana &&
ctx logger info  "Kibana Service running"

