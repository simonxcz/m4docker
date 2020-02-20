FROM alpine:latest

ENV USER=squash-tm
ENV PASSWORD=initial_pw
ENV DATABASE=squashtm
ENV NOM_HOST_CONTAINER=con_postgres_96
ENV PORT_BD=5432
ENV VERSION=1.21.0.RELEASE

ARG SQUASH_VERSION=squash-tm-${VERSION}.tar.gz

# Le EXPOSE 要和 service 的 port 一致，这里不可以 mapping
EXPOSE 8080

RUN apk add --update --no-cache bash curl tar openjdk8 postgresql-client
ADD ${SQUASH_VERSION} .

# 从此 WORKDIR 开始，工作路径为此 WORKDIR，直到下一个 WORKDIR. 如果不用 WORKDIR 而用 cd 的话，效果只持续一行命令
WORKDIR /squash-tm/bin 

RUN chmod +x startup.sh
RUN sed -i 's/DB_TYPE=h2/DB_TYPE=postgresql/g' startup.sh
RUN sed -i 's/DB_URL=jdbc:h2:..\/data\/squash-tm/DB_URL=jdbc:postgresql:\/\/${NOM_HOST_CONTAINER}:${PORT_BD}\/${DATABASE}/g' startup.sh
RUN sed -i "s/DB_USERNAME=sa/DB_USERNAME=\${USER}/g" startup.sh
RUN sed -i "s/DB_PASSWORD=sa/DB_PASSWORD=\${PASSWORD}/g" startup.sh

CMD psql postgresql //${USER}:${PASSWORD}@${NOM_HOST_CONTAINER}:${PORT_BD}/${DATABASE} ; if [ $? != 0 ] ; then psql postgresql://${USER}:${PASSWORD}@${NOM_HOST_CONTAINER}:${PORT_BD}/${DATABASE} -f ../database-scripts/postgresql-full-install-version-${VERSION}.sql; fi; ./startup.sh
