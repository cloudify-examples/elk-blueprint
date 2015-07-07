

#!/bin/bash

#ctx source instance runtime_properties elasticsearch_ip_address $(ctx target instance host_ip)
ELASTIC_IP=$(ctx target instance runtime_properties elasticsearch_ip_address)
ctx logger info "ElasticSearch IP is ${ELASTIC_IP}"    

#ctx source instance runtime_properties elasticsearch_port $(ctx target node properties port)
#ELASTIC_IP=$(ctx instance runtime_properties elasticsearch_ip_address)
if [ ! -e "/opt/logstash/conf/logstash.conf" ]
     then
        ctx logger info "logstash.conf was not found at /opt/logstash/conf/."
fi

ctx logger info  "Change Elastic IP"
sudo sed -i -e "s#elasticIP#${ELASTIC_IP}#g"   /opt/logstash/conf/logstash.conf
ctx logger info  "Starting Logstash with conf file"
sudo stop logstash
sudo start logstash
ctx logger info  "Logstash Service running after setting Elastic URL"  