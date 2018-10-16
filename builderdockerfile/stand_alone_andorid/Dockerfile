FROM hub.cloud.ctripcorp.com/build/centos:7.1.1503
#FROM hub.cloud.ctripcorp.com/base/centos:7.3.1611
#FROM hub.cloud.ctripcorp.com/jupyter_stacks/centos7_sshd:v1.0
#FROM hub.cloud.ctripcorp.com/mcdbase/mcd-general-slave-v2.1
#FROM hub.cloud.ctripcorp.com/buildslave/jenkins-slave-python



ENV user deploy
ENV group deploy
ENV uid 1000
ENV gid 1000
ENV JENKINS_AGENT_HOME /home/${user}
ENV AGENT_WORKDIR /home/${user}/agent


RUN rm -rf /etc/yum.repos.d/*
COPY CentOS7.repo /etc/yum.repos.d/  
COPY epel.repo /etc/yum.repos.d/  
COPY custom7.repo /etc/yum.repos.d/  
COPY remoting-3.9.jar /usr/share/jenkins/slave.jar 

RUN yum  install -y git && yum install -y openssh-server && yum install -y java-1.8.0-openjdk && yum install -y maven && yum install -y java-1.7.0-openjdk && yum install -y which &&\
    yum install -y python-pip   p7zip zip  &&\
    yum install -y gcc gcc-c++  &&\
    yum install -y python-devel  &&\
    yum install -y make  tar  &&\ 
    yum clean all

RUN mkdir /var/run/sshd
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key

RUN /bin/echo 'root:ca!!Duty'|chpasswd
RUN /bin/sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd
RUN /bin/echo -e "LANG=\"en_US.UTF-8\"" > /etc/default/local

##jenkins

RUN  chmod 755 /usr/share/jenkins \
     && chmod 644 /usr/share/jenkins/slave.jar



ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.85-2.6.1.2.el7_1.x86_64
ENV JRE_HOME=$JAVA_HOME/jre
ENV CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
ENV PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH

#ENV JENKINS_AGENT_HOME ${JENKINS_AGENT_HOME}
RUN groupadd -g ${gid} ${group} \
    && useradd -d "${JENKINS_AGENT_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}"

RUN /bin/echo 'deploy:ca!!Duty'|chpasswd

EXPOSE 22 

RUN mkdir /home/${user}/.pip
RUN mkdir /root/.pip
COPY pip.conf /home/deploy/.pip/
COPY pip.conf /root/.pip/

RUN pip install bsdiff4 requests biplist 
 
RUN yum install -y tar  &&\
    yum clean all

#VOLUME /home/deploy/build 
#RUN chmod +x -R /home/deploy/build/
#RUN chown -R deploy:deploy /home/deploy/build
#

####for RN/Hybird 
#ADD node-v8.2.1.tar.gz /home/deploy
#RUN cd /home/deploy/node-v8.2.1 &&  ./configure &&  make && make install
#
#RUN rm -rf  /home/deploy/node-v8.2.1  
#RUN npm config set registry http://registry.npm.release.ctripcorp.com 
#
#RUN npm install -g @ctrip/crn-build  && \
#    npm install -g @ctrip/crn-pack-v41 &&\
#    npm install -g  @ctrip/crn-pack-v51 &&\
#    npm install -g grunt && npm install -g grunt-cli 
#
#
#RUN yum install unzip  wget -y && yum clean all
#RUN pip install rsa 
#
#ADD H5.tar.gz /home/deploy/jenkins/
#RUN chmod +xw -R /home/deploy/jenkins/
#RUN chown -R deploy:deploy /home/deploy/jenkins
#
####for android bunld
RUN yum install -y  glibc-2.12-1.107.el6.i686 zlib.i686 libstdc++.i686 &&\
    yum reinstall -y glibc-common &&\
    yum -y groupinstall chinese-support &&\
    yum clean all 

RUN pip install python-swiftclient

#RUN /bin/echo -e "LANG=\"zh_CN.UTF-8\"" > /etc/sysconfig/i18n &&\
#    /bin/echo -e "SYSFONT=\"latarcyrheb-sun16\"" >> /etc/sysconfig/i18n &&\
#    /bin/echo -e "SUPPORTED=\"zh_CN.UTF-8:zh_CN:zh\"" >> /etc/sysconfig/i18n &&\
#    /bin/echo -e "LANG=\"zh_CN.UTF-8\"" > /etc/default/local &&\
#    /bin/echo -e "SYSFONT=\"latarcyrheb-sun16\"" >> /etc/default/local &&\
#    /bin/echo -e "SUPPORTED=\"zh_CN.UTF-8:zh_CN:zh\"" >> /etc/default/local 

#ENV LANG C.UTF-8
RUN /bin/echo -e "LANG=\"zh_CN.UTF-8\"" > /etc/default/local
ENV LANG zh_CN.UTF-8


#ENV LANG="zh_CN.UTF-8"

CMD ["/usr/sbin/sshd",  "-D"] 

RUN  /bin/echo 'export LANG=zh_CN.UTF-8'  >> /home/deploy/.bashrc
