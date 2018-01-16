FROM iflavoursbv/sbt-openjdk-8-alpine:0.13.15

MAINTAINER Arttu Oksanen
EXPOSE 9000
WORKDIR /opt/arpa
RUN git clone --depth 1 --branch master https://github.com/jiemakel/arpa /tmp/arpa-src
RUN cd /tmp/arpa-src \
  && sbt dist \
  && cd /tmp/arpa-src/target/universal/ \
  && unzip arpa-1.0-SNAPSHOT.zip \
  && cp -r arpa-1.0-SNAPSHOT/* /opt/arpa/ \
  && cd /opt/arpa \
  && rm -rf /tmp/arpa-src
VOLUME /opt/arpa/services
RUN ["chown", "-R", "daemon", "."]
USER daemon
ENV analyze_address=http://demo.seco.tkk.fi/las/analyze
CMD ./bin/arpa -Danalyze.address="$analyze_address"
