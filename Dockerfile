FROM exoplatform/ubuntu-jdk7
MAINTAINER scottwarren@ocom.com.au

# Update Ubuntu
RUN apt-get update && apt-get -y upgrade
# Add oracle java 7 repository
RUN apt-get -y install software-properties-common
RUN apt-get -y update

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
# ENV JAVA_HOME /usr/lib/jvm/java-7-oracle/jre

RUN /daisy/setup/config.sh

EXPOSE 8888
CMD ["/bin/bash"]
