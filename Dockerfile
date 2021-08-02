FROM tomcat:alpine  as build
MAINTAINER srinivas.bathuru@gmail.com

ENV TOMCAT_PATH /usr/local/tomcat/webapps/
ENV APP_NAME simpleapp

 WORKDIR /usr/local/tomcat/webapps/
 RUN pwd
 RUN echo "TOMCAT_PATH = "  $TOMCAT_PATH

COPY target/$APP_NAME*.war   $TOMCAT_PATH/$APP_NAME.war

# FROM alpine
# COPY --from=build   /usr/local/tomcat/   /usr/local/tomcat/
EXPOSE 8080


# COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
# COPY target/simpleapp*.war /usr/local/tomcat/webapps/simpleapp.war
