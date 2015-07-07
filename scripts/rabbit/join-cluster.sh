#!/bin/bash


#setCluster
sudo rabbitmqctl stop_app

MASTER_HOST_NAME=$(ctx target instance runtime_properties rabbitmqMaster_HostName)
ctx logger info  "Master HOSTNAME is ${MASTER_HOST_NAME}" 

MASTER_HOST_IP=$(ctx target instance runtime_properties rabbitmqMaster_ip)
ctx logger info  "Master HOSTNAME is ${MASTER_HOST_IP}" 

echo "${MASTER_HOST_IP}  ${MASTER_HOST_NAME}" | sudo tee --append /etc/hosts


sudo rabbitmqctl join_cluster rabbit@$MASTER_HOST_NAME

sudo rabbitmqctl start_app
ctx logger info  "Rabbitmq node joined cluster"


#if master
#change cookie to my_cookie OR get master cookie
#HOST_NAME=$HOSTNAME
#CLUSTER_NAME=$(ctx node properties "clusterName")
#sudo rm /var/lib/rabbitmq/.erlang.cookie 
#echo ${CLUSTER_NAME} | sudo tee -a  /var/lib/rabbitmq/.erlang.cookie 
# set master hostname
#ctx instance runtime_properties rabbitmqMaster_HostName ${HOST_NAME}
#ctx logger info  "HOSTNAME is ${HOST_NAME}"


#else if slave 