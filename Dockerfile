FROM ubuntu:precise
MAINTAINER Martin Chalupa <chalimartines@gmail.com>

#Install curl
RUN apt-get update
RUN apt-get install -y curl

#Install sudo
RUN apt-get install -y sudo
ADD conf/sudoers /etc/sudoers
RUN chmod u+r,g+r,o= /etc/sudoers

#Install CDH package
RUN curl http://archive.cloudera.com/cdh5/one-click-install/precise/amd64/cdh5-repository_1.0_all.deb > cdh5-repository_1.0_all.deb
RUN dpkg -i cdh5-repository_1.0_all.deb
RUN curl -s http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh/archive.key | apt-key add -
RUN apt-get update
RUN apt-get install -y hadoop-conf-pseudo

# Install package with add-apt-repository
RUN apt-get install -y python-software-properties

# Enable Ubuntu repositories with Oracle Java
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update

# Install latest Oracle Java from PPA
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
  apt-get install -y oracle-java7-installer oracle-java7-set-default

#Copy updated config files
ADD conf/core-site.xml /etc/hadoop/conf/core-site.xml
ADD conf/hdfs-site.xml /etc/hadoop/conf/hdfs-site.xml
ADD conf/mapred-site.xml /etc/hadoop/conf/mapred-site.xml
ADD conf/yarn-env.sh /etc/hadoop/conf/yarn-env.sh
ADD conf/yarn-site.xml /etc/hadoop/conf/yarn-site.xml

#Format HDFS
RUN sudo -u hdfs hdfs namenode -format

ADD conf/run-hadoop.sh /usr/bin/run-hadoop.sh
RUN chmod +x /usr/bin/run-hadoop.sh

# NameNode (HDFS)
EXPOSE 8020 50070

# DataNode (HDFS)
EXPOSE 50010 50020 50075

# ResourceManager (YARN)
EXPOSE 8030 8031 8032 8033 8088

# NodeManager (YARN)
EXPOSE 8040 8042

# JobHistoryServer
EXPOSE 10020 19888

CMD ["/usr/bin/run-hadoop.sh"]