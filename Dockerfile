# Centos based container with Java7 and Tomcat8
FROM centos:centos7
MAINTAINER Arpit Rastogi <frds.arastogi@gmail.com>

# Install prepare infrastructure
RUN yum -y update && \
 yum -y install wget && \
 yum -y install tar

# Prepare environment
ENV JAVA_HOME /opt/java
ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin:$CATALINA_HOME/scripts

# Install Oracle Java 7
ENV JAVA_VERSION 7u80

COPY ./jdk-7u80-linux-x64.tar.gz /

RUN tar -xvf jdk-${JAVA_VERSION}-linux-x64.tar.gz && \
 rm jdk*.tar.gz && \
 mv jdk* ${JAVA_HOME}

# Install Tomcat
ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.5.31

RUN wget http://mirror.linux-ia64.org/apache/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
 tar -xvf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
 rm apache-tomcat*.tar.gz && \
 mv apache-tomcat* ${CATALINA_HOME}

RUN chmod +x ${CATALINA_HOME}/bin/*sh

# Create Tomcat admin user
ADD create_admin_user.sh $CATALINA_HOME/scripts/create_admin_user.sh
ADD tomcat.sh $CATALINA_HOME/scripts/tomcat.sh
RUN chmod +x $CATALINA_HOME/scripts/*.sh

# Create tomcat user
RUN groupadd -r tomcat && \
 useradd -g tomcat -d ${CATALINA_HOME} -s /sbin/nologin  -c "Tomcat user" tomcat && \
 chown -R tomcat:tomcat ${CATALINA_HOME}

WORKDIR /opt/tomcat

EXPOSE 8080
EXPOSE 8009

USER tomcat
CMD ["tomcat.sh"]
