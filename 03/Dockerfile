FROM openjdk:8

ENV USER squash-tm
ENV PASSWORD=initial_pw
ENV DATABASE squashtm
ENV NOM_HOST_CONTAINER c_pg_02
ENV PORT 5432

ARG SQUASH_VERSION=squash-tm-1.21.0.RELEASE.tar.gz

EXPOSE 8080

RUN apt-get update
RUN apt-get install -y postgresql-client-9.6

ADD ${SQUASH_VERSION} .

WORKDIR /squash-tm/bin

RUN chmod +x startup.sh
RUN sed -i 's/DB_TYPE=h2/DB_TYPE=postgresql/g' startup.sh
RUN sed -i 's/DB_URL=jdbc:h2:..\/data\/squash-tm/DB_URL=jdbc:postgresql:\/\/c_pg_02:5432\/squashtm/g' startup.sh
RUN sed -i 's/DB_USERNAME=sa/DB_USERNAME=squash-tm/g' startup.sh
RUN sed -i 's/DB_PASSWORD=sa/DB_PASSWORD=initial_pw/g' startup.sh

CMD psql postgresql //${USER}:${PASSWORD}@${NOM_HOST_CONTAINER}:${PORT}/${DATABASE} ; if [ $? != 0 ]psql postgresql://${USER}:${PASSWORD}@{NOM_HOST_CONTAINER}:5432/squashtm -f ../database-scripts/postgresql-full-install-version-1.21.0.RELEASE.sql; ./startup.sh
