FROM tomcat:alpine  as build
LABEL MAINTAINER=srinivas.bathuru@gmail.com

ENV TOMCAT_PATH /usr/local/tomcat/webapps/
ENV APP_NAME simpleapp

WORKDIR /usr/local/tomcat/webapps/
RUN pwd
RUN echo "TOMCAT_PATH = "  $TOMCAT_PATH

COPY target/$APP_NAME*.war   $TOMCAT_PATH/$APP_NAME.war
EXPOSE 8080


# FROM alpine
# COPY --from=build   /usr/local/tomcat/   /usr/local/tomcat/
# COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
# COPY target/simpleapp*.war /usr/local/tomcat/webapps/simpleapp.war
