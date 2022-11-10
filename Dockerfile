FROM python:3.8.6-alpine
MAINTAINER am@homembr.ru

ENV DB_USER=sopds_user \
    DB_NAME=SOPDS2 \
    DB_PASS=12345678 \
    DB_HOST=172.17.0.1 \
    DB_PORT=3306 \
    EXT_DB=False \
    PORT=62015 \
    SOPDS_ROOT_LIB="/books" \
    SOPDS_INPX_ENABLE=false \
    SOPDS_LANGUAGE=ru-RU \
    MIGRATE=False \
    VERSION=0.48 \
    TZ=Europe/Saratov \
    LANG=ru_RU.UTF-8

ADD https://github.com/mitshel/sopds/archive/v0.48-devel.zip /sopds.zip

ADD ./scripts/start.sh /start.sh

RUN apk add --no-cache -U tzdata unzip libxml2-dev libxslt-dev libffi-dev jpeg-dev zlib-dev musl-utils musl-locales musl-locales-lang \
&& apk add --virtual build-deps gcc musl-dev \
&& cp /usr/share/zoneinfo/Europe/Saratov /etc/localtime \
&& echo "Europe/Samara" > /etc/timezone \
&& unzip -q /sopds.zip && rm /sopds.zip && mv sopds-* sopds \
&& apk add --no-cache mariadb-dev \
&& apk add mariadb-connector-c-dev \
&& pip3 install --upgrade pip && pip3 install -r /sopds/requirements.txt && pip3 install mysqlclient \
&& apk del build-deps gcc musl-dev mariadb-dev libxml2-dev libxslt-dev libffi-dev jpeg-dev \
&& apk add --no-cache -U libxml2 libxslt libffi libjpeg \
&& rm -rf /root/.cache/ \
&& mkdir -p /tmp/sopds \
#&& echo 'export LC_ALL=ru_RU.UTF-8' >> /etc/profile.d/locale.sh \
#&& sed -i 's|LANG=C.UTF-8|LANG=ru_RU.UTF-8|' /etc/profile.d/locale.sh \
&& chmod +x /start.sh

ADD ./configs/settings.py /sopds/sopds/settings.py

WORKDIR /sopds

VOLUME /usr/src/sopds/opds_catalog/log

EXPOSE $PORT

ENTRYPOINT ["/start.sh"]
