FROM openjdk:8

ENV USER=squash-tm
ENV PASSWORD=initial_pw
ENV DATABASE=squashtm
ENV NOM_HOST_CONTAINER=con_postgres_96
ENV PORT_BD=5432
ENV VERSION=1.21.0.RELEASE

ARG SQUASH_VERSION=squash-tm-${VERSION}.tar.gz

EXPOSE 8080

RUN apt-get update
RUN apt-get install -y postgresql-client-9.6

ADD ${SQUASH_VERSION} .

WORKDIR /squash-tm/bin

RUN chmod +x startup.sh
RUN sed -i 's/DB_TYPE=h2/DB_TYPE=postgresql/g' startup.sh
RUN sed -i 's/DB_URL=jdbc:h2:..\/data\/squash-tm/DB_URL=jdbc:postgresql:\/\/${NOM_HOST_CONTAINER}:${PORT_BD}\/${DATABASE}/g' startup.sh
RUN sed -i "s/DB_USERNAME=sa/DB_USERNAME=\${USER}/g" startup.sh
RUN sed -i "s/DB_PASSWORD=sa/DB_PASSWORD=\${PASSWORD}/g" startup.sh

CMD psql postgresql //${USER}:${PASSWORD}@${NOM_HOST_CONTAINER}:${PORT_BD}/${DATABASE} ; if [ $? != 0 ] ; then psql postgresql://${USER}:${PASSWORD}@${NOM_HOST_CONTAINER}:${PORT_BD}/${DATABASE} -f ../database-scripts/postgresql-full-install-version-${VERSION}.sql; fi; ./startup.sh
