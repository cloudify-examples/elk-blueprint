#!/bin/bash

set -e


function install_logstash()
{


    
    ctx logger info  "installing logstash"
    mkdir logstash
    sudo mkdir /opt/logstash
    sudo wget https://download.elasticsearch.org/logstash/logstash/logstash-1.5.0.tar.gz -O /opt/logstash.tar.gz
    sudo tar -xzvf /opt/logstash.tar.gz -C /opt/logstash --strip 1
    sudo rm /opt/logstash.tar.gz
    
    ctx logger info  "installing logstash contrib plugins"
    sudo /opt/logstash/bin/plugin install contrib
    mkdir -p logstash/conf &&
    

     ctx logger info  "Download conf file"
     ctx download-resource conf/logstash.conf '@{"target_path": "/home/ubuntu/elk/logstash/conf/logstash.conf"}'                                
     if [ -e "/home/ubuntu/elk/logstash/conf/logstash.conf"]
      then
         ctx logger info "logstash.conf was downloaded."
     fi
    sudo mkdir -p /opt/logstash/conf &&
    sudo cp /home/ubuntu/elk/logstash/conf/logstash.conf /opt/logstash/conf
    
    #ELASTIC_IP=$(ctx target instance runtime_properties elasticsearch_ip_address)
    #ctx logger info "ElasticSearch IP is ${ELASTIC_IP}"    
    #ctx logger info  "Change Elastic IP"
    #sudo sed -i -e "s#elasticIP#${ELASTIC_IP}#g"   /opt/logstash/conf/logstash.conf
    
    # create logstash upstart file
    echo 'description logstash' | sudo tee --append /etc/init/logstash.conf
    echo 'start on runlevel [2345]' | sudo tee --append /etc/init/logstash.conf
    echo 'stop on runlevel [016]' | sudo tee --append /etc/init/logstash.conf
    echo 'kill timeout 60' | sudo tee --append /etc/init/logstash.conf
    echo 'respawn' | sudo tee --append /etc/init/logstash.conf
    echo 'respawn limit 10 5' | sudo tee --append /etc/init/logstash.conf
    echo 'exec /opt/logstash/bin/logstash -f /opt/logstash/conf' | sudo tee --append /etc/init/logstash.conf
    #ctx logger info  "Starting Logstash with conf file"
    #sudo start logstash
  
    # conf should include basic filtering and elasticsearch IP
    #sudo logstash/bin/logstash -f logstash/conf/logstash.conf
}


function main()
{
    #ctx logger info  "Get ElasticSearch Host IP"
    #ELASTIC_HOST=$(ctx instance runtime_properties elasticsearch_ip_address)
    #ctx logger info  "ElasticSearch IP is ${ELASTIC_HOST}"


    ctx logger info  "bootstrapping..."

    ctx logger info  "updating db cache"
    sudo apt-get -y update &&
    ctx logger info  "installing dependencies"
    sudo apt-get install -y vim openjdk-7-jdk &&
    #sudo apt-get install -y vim openjdk-7-jdk python-dev curl git &&
    
    
    # go home
    cd ~
    mkdir -p elk &&
    cd elk &&
    install_logstash &&    
    
    ctx logger info  "bootstrap done"
}

main


#input { stdin { } }
#output {
#  elasticsearch { host => elasticIP }
#  stdout { codec => rubydebug }
#}