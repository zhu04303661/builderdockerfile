docker ps |grep sdk |grep -v grep
if [ $? -ne 0 ]
then
echo "start sdk volume ....."
docker rm sdk
docker run -it -d -v /home/deploy/build:/home/deploy/build --name sdk hub.cloud.ctripcorp.com/build/centos:7.1.1503 /bin/bash
else
echo "sdk volume still runing....."
fi
