FROM alpine:latest
ARG VERSION=1.4.4
ARG VERSIONCORTA=1.4

COPY files/createversion.sh /root

WORKDIR /root

RUN apk add --update openssl \
  && wget https://kent.dl.sourceforge.net/project/rkhunter/rkhunter/$VERSION/rkhunter-$VERSION.tar.gz \
  && tar -xvf rkhunter-$VERSION.tar.gz \
  && ls -lh \
  && cd /root/rkhunter-$VERSION \
  && mkdir -p /root/data/$VERSIONCORTA/i18n/$VERSION \
  && cp ./files/i18n/* /root/data/$VERSIONCORTA/i18n/$VERSION/ \
  && cp ./files/mirrors.dat ./files/programs_bad.dat ./files/backdoorports.dat ./files/suspscan.dat /root/data/ \
  && /root/createversion.sh $VERSION $VERSIONCORTA

FROM nginx:latest

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
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
