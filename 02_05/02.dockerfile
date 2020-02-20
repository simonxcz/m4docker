FROM 1and1internet/debian-9-postgresql-10

ADD squash-tm-1.21.0.RELEASE.tar.gz .

WORKDIR /var/www/squash-tm/bin

ADD postgresql-full-install-version-1.21.0.RELEASE.sql

RUN chmod +x startup.sh
RUN sed -i 's/DB_TYPE=*/DB_TYPE=postgresql/g' startup.sh
RUN sed -i 's/DB_URL=*/DB_URL=jdbc:postgresql:c_postgres_01/\/data\/squash-tm/g' startup.sh/
RUN sed -i 's/DB_USERNAME=*/DB_USERNAME=squash-tm/g' startup.sh
RUN sed -i 's/DB_PASSWORD=*/DB_PASSWORD=initial_pw/g' startup.sh
RUN psql postgresql://squash-tm@host/squashtm postgresql-full-install-version-1.21.0.RELEASE.sql



CMD ./startup.sh