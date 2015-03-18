#CDH 5 pseudo-distributed cluster Docker image

Do you develop Hadoop mapreduce applications on top of Cloudera distribution? This docker image can help you. It contains basic CDH 5 setup with YARN. You can use it for developmeent and verification of your code in local environment without messing up your system with Hadoop instalation.

Docker image was prepared according to [Installing CDH 5 with YARN on a Single Linux Node in Pseudo-distributed mode](http://www.cloudera.com/content/cloudera-content/cloudera-docs/CDH5/latest/CDH5-Quick-Start/cdh5qs_yarn_pseudo.html) with a few adjustments for Docker environment.

#####Installed services
* HDFS
* YARN
* JobHistoryServer
* Oozie

###Execution
Get docker image

    docker pull chalimartines/cdh5-pseudo-distributed:oozie

Run image with specified port mapping

    docker run --name cdh -d -p 8020:8020 -p 50070:50070 -p 50010:50010 -p 50020:50020 -p 50075:50075 -p 8030:8030 -p 8031:8031 -p 8032:8032 -p 8033:8033 -p 8088:8088 -p 8040:8040 -p 8042:8042 -p 10020:10020 -p 19888:19888 -p 11000:11000 chalimartines/cdh5-pseudo-distributed
  
If you are Mac OS user with boot2docker and you would like to get from your local system to a cdh container add these port forwardings

	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8020,tcp,,8020,,8020"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port50070,tcp,,50070,,50070"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port50010,tcp,,50010,,50010"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port50020,tcp,,50020,,50020"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port50075,tcp,,50075,,50075"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8030,tcp,,8030,,8030"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8031,tcp,,8031,,8031"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8032,tcp,,8032,,8032"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8033,tcp,,8033,,8033"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8088,tcp,,8088,,8088"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8040,tcp,,8040,,8040"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8042,tcp,,8042,,8042"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port10020,tcp,,10020,,10020"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port19888,tcp,,19888,,19888"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port11000,tcp,,11000,,11000"
