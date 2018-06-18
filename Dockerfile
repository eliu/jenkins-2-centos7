FROM openshift/jenkins-2-centos7

MAINTAINER eliu
LABEL maintainer="eliu"

WORKDIR $JENKINS_HOME

USER root

ENV TZ Asia/Shanghai
ENV MAVEN_MAJOR 3
ENV MAVEN_VERSION 3.5.3
ENV MAVEN_URL http://mirror.bit.edu.cn/apache/maven/maven-$MAVEN_MAJOR/$MAVEN_VERSION/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
ENV M2_HOME /opt/apache-maven-${MAVEN_VERSION}
ENV DOCKER_VERSION 17.09.0-ce
ENV DOCKER_URL https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz

# Setup timezone and install maven
RUN set -x \
	# Install docker client
	&& curl -#SLO ${DOCKER_URL} \
	&& tar xvzf docker-$DOCKER_VERSION.tgz \
	&& mv docker/docker /usr/local/bin/docker \
	&& rm -rf docker* \
	# Install Apache Maven
	&& curl -#SLO $MAVEN_URL \
	&& tar -xvf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt \
	&& ln -s $M2_HOME/bin/mvn /usr/local/bin/ \
	&& rm -f apache-maven-${MAVEN_VERSION}-bin.tar.gz

USER 1001
