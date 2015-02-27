#!/bin/bash

export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:/usr/share/java/slf4j-simple.jar:/usr/share/java/zookeeper.jar
export HADOOP_OPTS="-Djava.net.preferIPv4Stack=true $HADOOP_CLIENT_OPTS"
