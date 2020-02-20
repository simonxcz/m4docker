FROM 1and1internet/debian-9-java-8


# Installer Squash TM
# RUN apt-cache search wget
# RUN apt-cache search wget | grep wget
# RUN apt search wget
# RUN sudo apt install wget
# RUN wget http://repo.squashtest.org/distribution/squash-tm-1.21.0.RELEASE.tar.gz
ADD squash-tm-1.21.0.RELEASE.tar.gz .

WORKDIR /var/www/squash-tm/bin

EXPOSE port 8080

RUN chmod +x startup.sh

CMD ./startup.sh