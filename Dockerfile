FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install python-software-properties ;\
    echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list ;\
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list ;\
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update 

# Java 7
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer wget build-essential zlib1g-dev libyaml-dev libssl-dev libgdbm-dev libreadline-dev libncurses5-dev libffi-dev curl openssh-server libxml2-dev libxslt-dev libcurl4-openssl-dev libicu-dev logrotate libpq-dev sudo git supervisor ruby2.1 ruby2.1-dev
 
# elasticsearch
RUN cd /opt; wget --no-check-certificate https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.10.tar.gz ;\
    cd /opt; tar -xf elasticsearch-0.90.10.tar.gz ;\
    cd /opt; rm elasticsearch-0.90.10.tar.gz ;\
    mv /opt/elasticsearch-0.90.10 /opt/elasticsearch
 
EXPOSE 9200
 
CMD /opt/elasticsearch-0.90.10/bin/elasticsearch -f
