# Utiliza una imagen base de Ubuntu
FROM ubuntu:latest

# Instala OpenJDK 17
RUN apt-get update && apt-get install -y openjdk-17-jdk

# Instala Nginx
RUN apt-get install -y nginx

# Descarga y configura Tomcat 10.1.23
ENV TOMCAT_VERSION=10.1.23
ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH

RUN wget -q https://dlcdn.apache.org/tomcat/tomcat-10/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz -O tomcat.tar.gz \
    && tar -xvf tomcat.tar.gz \
    && mv apache-tomcat-$TOMCAT_VERSION $CATALINA_HOME \
    && rm tomcat.tar.gz \
    && rm -rf $CATALINA_HOME/webapps/examples $CATALINA_HOME/webapps/docs

# Exponer el puerto 8080 para Tomcat y el puerto 80 para Nginx
EXPOSE 8080
EXPOSE 80

# Configurar Nginx como proxy para Tomcat
COPY nginx.conf /etc/nginx/sites-available/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Comando para iniciar Nginx y Tomcat cuando se inicie el contenedor
CMD service nginx start && catalina.sh run
