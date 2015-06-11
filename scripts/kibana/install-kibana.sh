#!/bin/bash

set -e


function install_kibana()
{
    #elasticsearch_ip=$1

    ctx logger info  "installing kibana"
    sudo mkdir /opt/kibana
    sudo wget https://download.elastic.co/kibana/kibana/kibana-4.0.2-linux-x64.tar.gz -O /opt/kibana.tar.gz

    sudo tar -xzvf /opt/kibana.tar.gz -C /opt/kibana --strip-components=1
    #update the kibana.yml to the elasticsearch IP
    #sudo sed -i -e 's#elasticsearch_url: "http://localhost:9200"#elasticsearch_url: "http://${elasticsearch_ip}:9200"#g' /opt/kibana/config/kibana.yml
    
    #ELASTIC_IP=$(ctx target instance runtime_properties elasticsearch_ip_address)
    #update the kibana.yml to the elasticsearch IP
    #sudo sed -i -e 's#elasticsearch_url: "http://localhost:9200"#elasticsearch_url: "http://${ELASTIC_IP}:9200"#g' /opt/kibana/config/kibana.yml
    ctx logger info  "Updating upstart for kibana"

    # create kibana upstart file
    echo 'description kibana' | sudo tee --append /etc/init/kibana.conf
    echo 'start on runlevel [2345]' | sudo tee --append /etc/init/kibana.conf
    echo 'stop on runlevel [016]' | sudo tee --append /etc/init/kibana.conf
    echo 'kill timeout 60' | sudo tee --append /etc/init/kibana.conf
    echo 'respawn' | sudo tee --append /etc/init/kibana.conf
    echo 'respawn limit 10 5' | sudo tee --append /etc/init/kibana.conf
    echo 'exec /opt/kibana/bin/kibana' | sudo tee --append /etc/init/kibana.conf
    #sudo start kibana
    sudo rm /opt/kibana.tar.gz
    ctx logger info  " Finished installing kibana"

}

function main()
{
    #ctx logger info  "Get ElasticSearch Host IP"
    #ELASTIC_HOST=$(ctx instance runtime_properties elasticsearch_ip_address)
    # ctx logger info  "ElasticSearch IP is ${ELASTIC_HOST}"

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
    
    install_kibana &&
    
    ctx logger info  "Bootstrap done"
}

main
