FROM quay.io/ibm/ubuntu:20.04

# The author
LABEL maintainer="LoZ Open Source Ecosystem (https://www.ibm.com/community/z/usergroups/opensource)"

ENV SOURCE_DIR=/home/
ENV JAVA_HOME=/home/jdk-11.0.5+10
ENV PATH=$PATH:$SOURCE_DIR/:$JAVA_HOME/bin
ENV VERSION=2.12-2.5.0

WORKDIR $SOURCE_DIR

# Install dependencies
RUN	apt-get update && apt-get -y install \
	git \
	unzip \
	wget \
# Download Adopt JDK
  && wget https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.5%2B10/OpenJDK11U-jdk_s390x_linux_hotspot_11.0.5_10.tar.gz \
  && tar -xvzf OpenJDK11U-jdk_s390x_linux_hotspot_11.0.5_10.tar.gz \
  && rm OpenJDK11U-jdk_s390x_linux_hotspot_11.0.5_10.tar.gz \
# Download the Apache Kafka Binary
 && wget http://mirrors.estointernet.in/apache/kafka/2.5.0/kafka_${VERSION}.tgz \
 && tar -xvzf kafka_${VERSION}.tgz \
 && rm kafka_${VERSION}.tgz \
 && mv kafka_${VERSION} kafka
# Expose ports for Apache ZooKeeper and kafka
EXPOSE 2181 9092

WORKDIR $SOURCE_DIR/kafka/

# start zookeeper and kafka server
CMD bin/zookeeper-server-start.sh -daemon config/zookeeper.properties && sleep 20 && bin/kafka-server-start.sh config/server.properties > /dev/null

# End of Dockerfile
