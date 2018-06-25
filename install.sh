#!/bin/bash

echo "Europe/Warsaw" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata
sudo locale-gen pl_PL.UTF-8
sudo apt-get update
sudo apt-get install unzip
sudo apt-get install apt-transport-https

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
sudo apt-get install -y elasticsearch=6.2.4

printf "network.bind_host: 0\n" >> /etc/elasticsearch/elasticsearch.yml
printf "network.host: 0.0.0.0\n" >> /etc/elasticsearch/elasticsearch.yml
printf "http.port: 9200\n" >> /etc/elasticsearch/elasticsearch.yml
printf "xpack.security.enabled: false\n" >> /etc/elasticsearch/elasticsearch.yml

sudo systemctl daemon-reload
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch

#sudo /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-stempel

#sudo mkdir /etc/elasticsearch/hunspell/pl_PL/
#cd /etc/elasticsearch/hunspell/pl_PL/
#sudo wget http://download.services.openoffice.org/contrib/dictionaries/pl_PL.zip
#sudo unzip pl_PL.zip
#sudo rm -rf pl_PL.zip

sudo systemctl restart elasticsearch

####################################################################################
##################################### KIBANA #######################################
####################################################################################

sudo apt-get install -y kibana=6.2.4

sudo systemctl daemon-reload
sudo systemctl enable kibana

printf "server.host: \"0.0.0.0\"\n" >> /etc/kibana/kibana.yml
printf "elasticsearch.url: \"http://localhost:9200\"\n" >> /etc/kibana/kibana.yml

sudo systemctl start kibana

####################################################################################
################################### LOGSTASH #######################################
####################################################################################

#sudo apt-get install -y logstash
#sudo /etc/init.d/logstash start

####################################################################################
################################# MORFOLOGIK #######################################
####################################################################################

sudo /usr/share/elasticsearch/bin/elasticsearch-plugin install pl.allegro.tech.elasticsearch.plugin:elasticsearch-analysis-morfologik:6.2.4
