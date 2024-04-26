FROM ubuntu:latest

# Instala OpenJDK 17
RUN apt-get update && apt-get install -y openjdk-17-jdk

# Instala Nginx
RUN apt-get install -y nginx

# Descarga Tomcat 10.1 y configura
ENV TOMCAT_MAJOR=10
ENV TOMCAT_VERSION=10.1.0
ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH

RUN apt-get install -y wget \
    && wget -O tomcat.tar.gz https://downloads.apache.org/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz \
    && tar -xvf tomcat.tar.gz \
    && mv apache-tomcat-$TOMCAT_VERSION $CATALINA_HOME \
    && rm tomcat.tar.gz \
    && rm -rf $CATALINA_HOME/webapps/examples $CATALINA_HOME/webapps/docs

# Exponer el puerto 80 para Nginx y 8080 para Tomcat
EXPOSE 80
EXPOSE 8080
