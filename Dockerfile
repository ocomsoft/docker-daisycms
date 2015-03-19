FROM ubuntu:14.04
MAINTAINER scottwarren@ocom.com.au

# Update Ubuntu
RUN apt-get update && apt-get -y upgrade
# Add oracle java 7 repository
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get -y update
# Accept the Oracle Java license
RUN echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
# Install Oracle Java
RUN apt-get -y install oracle-java7-installer
# Install tomcat
#RUN apt-get -y install tomcat7
#RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/default/tomcat7
RUN ( echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections )

RUN apt-get install -y sendmail
RUN apt-get install -y mysql-server

RUN mkdir -p /daisy/setup
WORKDIR /daisy

RUN wget http://internode.dl.sourceforge.net/project/daisycms/daisycms/2.4.2/daisy-2.4.2.tar.gz

RUN tar xvzf /daisy/daisy-2.4.2.tar.gz 

COPY data /daisy/setup

ENV DAISY_HOME /daisy/daisy-2.4.2
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle/jre

RUN /daisy/setup/config.sh

EXPOSE 8888
CMD ["/bin/bash"]
