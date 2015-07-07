

#!/bin/bash

#ctx source instance runtime_properties rabbitmq_ip_address $(ctx target instance host_ip)
RABBIT_IP=$(ctx target instance runtime_properties rabbitmqMaster_ip)
ctx logger info "Rabbitmq IP is ${RABBIT_IP}"    

#ctx source instance runtime_properties elasticsearch_port $(ctx target node properties port)
#ELASTIC_IP=$(ctx instance runtime_properties elasticsearch_ip_address)
if [ ! -e "/opt/logstash/conf/logstash.conf" ]
     then
        ctx logger info "logstash.conf was not found at /opt/logstash/conf/."
fi

ctx logger info  "Change RabbitMQ IP"
sudo sed -i -e "s#rabbitIP#${RABBIT_IP}#g"   /opt/logstash/conf/logstash.conf
ctx logger info  "Starting Logstash with conf file"
sudo stop logstash
sudo start logstash 
ctx logger info  "Logstash Service running after setting Rabbitmq URL"  