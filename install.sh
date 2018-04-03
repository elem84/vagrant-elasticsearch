#!/bin/bash

echo "Europe/Warsaw" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata
sudo locale-gen pl_PL.UTF-8

####################################################################################
###################################### JAVA ########################################
####################################################################################

sudo apt-get install -y software-properties-common python-software-properties
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo apt-get install -y oracle-java8-set-default

######################################################################################
################################# ELASTIC SEARCH #####################################
######################################################################################

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list

sudo apt-get update
sudo apt-get install -y elasticsearch

printf "network.bind_host: 0\n" >> /etc/elasticsearch/elasticsearch.yml
printf "network.host: 0.0.0.0\n" >> /etc/elasticsearch/elasticsearch.yml
printf "http.port: 9200\n" >> /etc/elasticsearch/elasticsearch.yml

####################################################################################
##################################### KIBANA #######################################
####################################################################################

sudo systemctl daemon-reload
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch

sudo apt-get install -y kibana

sudo systemctl daemon-reload
sudo systemctl enable kibana

printf "server.host: \"0.0.0.0\"\n" >> /etc/kibana/kibana.yml
printf "elasticsearch.url: \"http://localhost:9200\"\n" >> /etc/kibana/kibana.yml

sudo systemctl start kibana
