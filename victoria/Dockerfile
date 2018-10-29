FROM openjdk:8-jre-slim

RUN useradd --home-dir /home/victoria --create-home -U victoria

COPY bin/service.sh bin/server.sh /home/victoria/bin/
COPY etc/service.yml /home/victoria/etc/
COPY lib/service.jar /home/victoria/lib/

RUN chmod 770 -R /home/victoria/
RUN chown victoria -R /home/victoria/

USER victoria
EXPOSE 8090 8091
ENTRYPOINT ["/home/victoria/bin/server.sh"]