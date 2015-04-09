FROM dockerfile/java:oracle-java7
MAINTAINER Martin Chalupa <chalimartines@gmail.com>

#Base image doesn't start in root
WORKDIR /

#Add the CDH 5 repository
RUN sudo wget 'http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/cloudera.list' -O /etc/apt/sources.list.d/cloudera.list
#Set preference for cloudera packages
COPY conf/cloudera.pref /etc/apt/preferences.d/cloudera.pref

#Add a Repository Key
RUN wget http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key -O archive.key && sudo apt-key add archive.key && \
    sudo apt-get update

#Install CDH package
RUN sudo apt-get install -y zookeeper-server && \
    sudo apt-get install -y hadoop-conf-pseudo && \
    sudo apt-get install -y oozie

#Copy updated config files
COPY conf/core-site.xml /etc/hadoop/conf/core-site.xml
COPY conf/hdfs-site.xml /etc/hadoop/conf/hdfs-site.xml
COPY conf/mapred-site.xml /etc/hadoop/conf/mapred-site.xml
COPY conf/hadoop-env.sh /etc/hadoop/conf/hadoop-env.sh
COPY conf/yarn-site.xml /etc/hadoop/conf/yarn-site.xml

#Format HDFS
RUN sudo -u hdfs hdfs namenode -format

COPY conf/run-hadoop.sh /usr/bin/run-hadoop.sh
RUN chmod +x /usr/bin/run-hadoop.sh

RUN sudo -u oozie /usr/lib/oozie/bin/ooziedb.sh create -run && \
    wget http://archive.cloudera.com/gplextras/misc/ext-2.2.zip -O ext.zip && \
    unzip ext.zip -d /var/lib/oozie

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
