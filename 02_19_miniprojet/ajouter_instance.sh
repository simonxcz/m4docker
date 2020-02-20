#! /bin/bash

work_dir=/home/formation/tmp/exercies/02_19_miniprojet
# type_bd=$1

cd ${work_dir}/$1
docker-compose -p squash-tm-$s1-$(date +'%Y%m%d%H%m%s') up -d