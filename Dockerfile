FROM damm/java8
MAINTAINER Nicolas Toublanc "n.toublanc@gmail.com"

EXPOSE 8080

ENV TOMCAT_VERSION 8.0.5

RUN apt-get update && apt-get clean
RUN apt-get install -q -y openssh-server
RUN apt-get clean

RUN mkdir /var/run/sshd
RUN echo 'root:tomcat' |chpasswd

RUN wget --quiet --no-cookies http://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/catalina.tar.gz

# Unpack
RUN tar xzf /tmp/catalina.tar.gz -C /opt
RUN mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat
RUN rm /tmp/catalina.tar.gz

# Remove all existing apps
RUN rm -rf /opt/tomcat/webapps/*

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

# Add deployment scripts
ADD run.sh /docker/bin/run.sh
RUN chmod 755 /docker/bin/*.sh
ADD tomcat-control.sh /etc/init.d/tomcat
RUN chmod 755 /etc/init.d/tomcat

# volumes
VOLUME  ["/docker/deploy", "/opt/tomcat/logs"]

# Start Tomcat
CMD ["/docker/bin/run.sh"]
