FROM hub.cloud.ctripcorp.com/dockerservice/tools:prod
#FROM hub.cloud.ctripcorp.com/build/centos:7.1.1503
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

COPY remoting-3.9.jar /usr/share/jenkins/slave.jar 

ADD H5.tar.gz /home/deploy/jenkins/
RUN chmod +xw -R /home/deploy/jenkins/ &&\
    chown -R deploy:deploy /home/deploy/jenkins

RUN yum  install -y git \
                    java-1.8.0-openjdk \
                    java-1.7.0-openjdk \
                    maven \
		    unzip  wget tar   which  p7zip zip  \
                    gcc gcc-c++  \
                    python-devel  \
                    make &&\ 
    yum clean all 
#RUN yum install -y glibc-2.12-1.107.el6.i686 zlib.i686 libstdc++.i686 &&\
#    yum reinstall -y glibc-common &&\
#    yum clean all 

 

RUN /bin/echo 'root:ca!!Duty'|chpasswd
RUN /bin/sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd

##jenkins
RUN  chmod 755 /usr/share/jenkins \
     && chmod 644 /usr/share/jenkins/slave.jar

#JAVA ENV
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.85-2.6.1.2.el7_1.x86_64
ENV JRE_HOME=$JAVA_HOME/jre
ENV CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
ENV PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
#RUN groupadd -g ${gid} ${group} \
#    && useradd -d "${JENKINS_AGENT_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}"

RUN /bin/echo 'deploy:ca!!Duty'|chpasswd


VOLUME /home/deploy/build 
RUN chmod +x -R /home/deploy/build/ &&\
    chown -R deploy:deploy /home/deploy/build


###InStall Nodejs for RN/Hybird 
ADD node-v6.2.0.tar.gz /home/deploy
RUN cd /home/deploy/node-v6.2.0 &&\
    ./configure &&\
    make &&\
    make install &&\
    rm -rf  /home/deploy/node-v6.2.0  

RUN pip install bsdiff4 requests biplist rsa  python-swiftclient

CMD ["/usr/sbin/sshd",  "-D"] 
RUN npm config set registry http://registry.npm.release.ctripcorp.com &&\
    npm install -g @ctrip/crn-build  && \
    npm install -g @ctrip/crn-pack-v41 &&\
    npm install -g @ctrip/crn-pack-v51 &&\
    npm install -g grunt && npm install -g grunt-cli 

ENV JRE_HOME=$JAVA_HOME/jre
RUN  /bin/echo 'export LANG=zh_CN.UTF-8'  >> /home/deploy/.bashrc &&\
     localedef --quiet -c -i zh_CN -f UTF-8 zh_CN.UTF-8

ENV LANG=zh_CN.UTF-8 LANGUAGE=zh_CN:en LC_ALL=zh_CN.UTF-8

#prod env
##echo "\n PROD ENV===========================================================================\n\n"
#RUN npm uninstall -g @ctrip/crn-build  && npm install -g @ctrip/crn-build --registry=http://registry.npm.release.ctripcorp.com &&\
#    rm -rf /usr/local/lib/node_modules/\@ctrip/crn-build/node_modules/node-haste/lib/DependencyGraph/HasteMap.js && \
#    cp /usr/local/lib/node_modules/\@ctrip/crn-build/HasteMap.js /usr/local/lib/node_modules/\@ctrip/crn-build/node_modules/node-haste/lib/DependencyGraph/HasteMap.js 



