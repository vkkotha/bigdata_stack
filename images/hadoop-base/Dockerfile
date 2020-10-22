# Note: This Dockerfile is based on https://hub.docker.com/r/bde2020/hadoop-base
# The following changes have been made:
#
# 1. Hadoop updated to 2.8.5
# 2. Base image updated to debian 9

FROM debian:9
MAINTAINER johs@johs.me

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends openjdk-8-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends net-tools curl netcat gnupg procps wget

RUN curl -L https://www.apache.org/dist/hadoop/common/KEYS -o /tmp/KEYS
RUN gpg --import /tmp/KEYS; exit 0
ENV HADOOP_VERSION 2.8.5
ENV AWS_VERSION=1.10.75.2
ENV MULTIHOMED_NETWORK=1
ENV HADOOP_PREFIX=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop

ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz* \
    && rm /tmp/KEYS
    
RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop
RUN cp /etc/hadoop/mapred-site.xml.template /etc/hadoop/mapred-site.xml
RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

RUN mkdir /hadoop-data

# Install Tez
ENV TEZ_VERSION 0.9.2
# ENV TEZ_URL https://www.apache.org/dist/tez/${TEZ_VERSION}/apache-tez-${TEZ_VERSION}-bin.tar.gz
ENV TEZ_CONF_DIR /etc/tez/conf
# ENV TEZ_HOME /opt/tez/apache-tez-${TEZ_VERSION}-bin
# RUN mkdir -p ${TEZ_CONF_DIR}
# ADD conf/tez-site.xml ${TEZ_CONF_DIR}
# RUN curl -L https://dist.apache.org/repos/dist/release/tez/KEYS -o /tmp/tez.KEYS
# RUN gpg --import /tmp/tez.KEYS;exit 0
# RUN set -x \
#     && curl -fSL "$TEZ_URL" -o /tmp/apache-tez-${TEZ_VERSION}.tar.gz \
#     && curl -fSL "$TEZ_URL.asc" -o /tmp/apache-tez-${TEZ_VERSION}.tar.gz.asc \
#     && gpg --verify /tmp/apache-tez-${TEZ_VERSION}.tar.gz.asc \
#     && mkdir -p /opt/tez \
#     && tar -xvf /tmp/apache-tez-${TEZ_VERSION}.tar.gz -C /opt/tez \
#     && tar -xvf /opt/tez/apache-tez-${TEZ_VERSION}-bin/share/tez.tar.gz -C /opt/tez/apache-tez-${TEZ_VERSION}-bin/share \
#     && rm /tmp/apache-tez-${TEZ_VERSION}.tar.gz* \
#     && rm /tmp/tez.KEYS

RUN mkdir -p /opt/tez/tez-dist
RUN mkdir -p /opt/tez/tez-client
RUN mkdir -p ${TEZ_CONF_DIR}
COPY tez-${TEZ_VERSION}-minimal.tar.gz /opt/tez/tez-dist
COPY tez-${TEZ_VERSION}.tar.gz /opt/tez/tez-dist
ADD conf/tez-site.xml ${TEZ_CONF_DIR}

RUN tar -xvf /opt/tez/tez-dist/tez-${TEZ_VERSION}-minimal.tar.gz -C /opt/tez/tez-client
COPY conf/add-aux-jars.sh ${HADOOP_PREFIX}/sbin
RUN chmod 744 ${HADOOP_PREFIX}/sbin/add-aux-jars.sh

# Fix AWS Jars
# RUN (cd ${HADOOP_PREFIX}/share/hadoop/tools/lib && rm -f aws-java-sdk*.jar && cd -)
# RUN (cd ${HADOOP_PREFIX}/share/hadoop/tools/lib \
#     && set -x \
#     && curl -L "https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/${AWS_VERSION}/aws-java-sdk-${AWS_VERSION}.jar" -o aws-java-sdk-${AWS_VERSION}.jar \
#    	&& curl -L "https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-core/${AWS_VERSION}/aws-java-sdk-core-${AWS_VERSION}.jar" -o aws-java-sdk-core-${AWS_VERSION}.jar \
#    	&& curl -L "https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/${AWS_VERSION}/aws-java-sdk-s3-${AWS_VERSION}.jar" -o aws-java-sdk-s3-${AWS_VERSION}.jar \
#     && cd -)


ENV USER=root
ENV PATH $HADOOP_PREFIX/bin/:$PATH

COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
