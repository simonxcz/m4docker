FROM debian
RUN apt-get update
RUN apt-get -y install openssh-server python python.pip
RUN mkdir -p /root/.ssh/
ADD ansible_rsa.pub /root/.ssh/authorized_keys