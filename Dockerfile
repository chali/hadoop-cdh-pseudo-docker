FROM dockerfile/java:oracle-java7
MAINTAINER Martin Chalupa <chalimartines@gmail.com>

#Base image doesn't start in root
WORKDIR /

#Install CDH package
RUN curl http://archive.cloudera.com/cdh5/one-click-install/precise/amd64/cdh5-repository_1.0_all.deb > cdh5-repository_1.0_all.deb
RUN dpkg -i cdh5-repository_1.0_all.deb
RUN curl -s http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh/archive.key | apt-key add -
RUN apt-get update
RUN apt-get install -y hadoop-conf-pseudo

#Copy updated config files
ADD conf/core-site.xml /etc/hadoop/conf/core-site.xml
ADD conf/hdfs-site.xml /etc/hadoop/conf/hdfs-site.xml
ADD conf/mapred-site.xml /etc/hadoop/conf/mapred-site.xml
ADD conf/hadoop-env.sh /etc/hadoop/conf/hadoop-env.sh
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
