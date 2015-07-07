#!/bin/bash

#set -e

echo "deb http://www.rabbitmq.com/debian/ testing main"  | sudo tee  /etc/apt/sources.list.d/rabbitmq.list > /dev/null
sudo wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
ctx logger info "Add rabbitMQ to apt"
sudo apt-key add rabbitmq-signing-key-public.asc
ctx logger info "Updating system"
sudo apt-get update
ctx logger info "Installing RabbitMQ"
sudo apt-get install rabbitmq-server -y

sudo service rabbitmq-server stop

CLUSTER_NAME=$(ctx node properties "clusterName")
ctx logger info "****************************Set the Rabbitmq cookie"
#sudo rm /var/lib/rabbitmq/.erlang.cookie 
echo ${CLUSTER_NAME} | sudo tee /var/lib/rabbitmq/.erlang.cookie 
ctx logger info "*****************************Rabbitmq cookie was set"

echo "ulimit -n 65536" | sudo tee --append /etc/default/rabbitmq-server


ctx logger info "Starting rabbit"
sudo service rabbitmq-server start
sudo rabbitmq-plugins enable rabbitmq_management
ctx logger info "Restarting rabbit"
sudo service rabbitmq-server restart

ctx logger info  "Add User to Rabbitmq"
sudo rabbitmqctl add_user cfyuser cfypass
sudo rabbitmqctl set_user_tags cfyuser administrator
sudo rabbitmqctl set_permissions -p / cfyuser ".*" ".*" ".*"


ctx logger info  "Rabbitmq node bootstrap done"
