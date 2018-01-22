# PASO 1
FROM alpine:latest

ARG VERSIONRK=1.4.4
ARG VERSIONRKCORTA=1.4

COPY files/createVERSIONRK.sh /root

WORKDIR /root

RUN apk add --update openssl \
  && wget "https://sourceforge.net/projects/rkhunter/files/latest/download?source=files" -O rkhunter-$VERSIONRK.tar.gz\
  && tar -xf rkhunter-$VERSIONRK.tar.gz \
  && cd /root/rkhunter-$VERSIONRK \
  && mkdir -p /root/data/$VERSIONRKCORTA/i18n/$VERSIONRK \
  && cp ./files/i18n/* /root/data/$VERSIONRKCORTA/i18n/$VERSIONRK/ \
  && cp ./files/mirrors.dat ./files/programs_bad.dat ./files/backdoorports.dat ./files/suspscan.dat /root/data/ \
  && /root/createVERSIONRK.sh $VERSIONRK $VERSIONRKCORTA

# PASO 2
FROM nginx:latest

ARG BUILD_DATE
ARG VCS_REF
ARG VERSIONRK
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="rkhunter-localmirror" \
      org.label-schema.description="rkhunter mirror for updates" \
      org.label-schema.url="http://andradaprieto.es" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/jandradap/rkhunter-localmirror" \
      org.label-schema.vendor="Jorge Andrada Prieto" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0" \
      maintainer="Jorge Andrada Prieto <jandradap@gmail.com>" \
      org.label-schema.docker.cmd="docker run --name=rkhunter-mirror -p 8080:80 -d jorgeandrada/rkhunter-localmirror"

COPY files/entrypoint.sh /root
RUN rm /usr/share/nginx/html/* \
  && sed -i 'N; s/root   \/usr\/share\/nginx\/html;\n        index  index.html index.htm;/root   \/usr\/share\/nginx\/html;\n        autoindex on;/' /etc/nginx/conf.d/default.conf
COPY --from=0 /root/data/* /usr/share/nginx/html/
WORKDIR /usr/share/nginx/html
ENTRYPOINT ["/root/entrypoint.sh"]
