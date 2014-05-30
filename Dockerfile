FROM centos
MAINTAINER Sönke Liebau soenke.liebau@gmail.com

# Install utilities
RUN yum install -y wget tar gzip java-1.7.0-openjdk-devel
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk.x86_64

# Add EPEL repo for supervisor and install supervisor
RUN wget http://mirror-fpt-telecom.fpt.net/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
RUN rpm -ivh epel-release-6-8.noarch.rpm
RUN yum install -y supervisor redis

# Download and install logstash
RUN wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.1.tar.gz
RUN tar xvfz logstash-1.4.1.tar.gz
RUN mv logstash-1.4.1 /usr/share/

# Set environment variables for config file and log directory used in supervisor config file
ENV LOGSTASH_CONFIG_FILE /conf/logstash.conf

# Add supervisord.conf file 
ADD supervisord.conf /etc/supervisord.conf

# Expose redis port so we can get data into the pipeline 
EXPOSE 6379 

CMD ["/usr/bin/supervisord"]
