FROM centos:latest
MAINTAINER Booz Allen Hamilton <opendataplatform@bah.com>

# install yum repos
RUN yum update -y &&\
    yum install -y which wget git java-1.8.0-openjdk python && yum clean all

ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0-openjdk
RUN export JAVA_HOME

ENV NIFI_VERSION=1.1.2 \
        NIFI_HOME=/opt/nifi \
        MIRROR_SITE=http://apache.mirrors.lucidnetworks.net

# Picked the recommended mirror from Apache for the distribution.
# Import the Apache NiFi release keys, download the release, and set up a user to run NiFi.
RUN set -x \
        && curl -Lf https://dist.apache.org/repos/dist/release/nifi/KEYS -o /tmp/nifi-keys.txt \
        && gpg --import /tmp/nifi-keys.txt \
        && curl -Lf ${MIRROR_SITE}/nifi/${NIFI_VERSION}/nifi-${NIFI_VERSION}-bin.tar.gz -o /tmp/nifi-bin.tar.gz \
        && mkdir -p ${NIFI_HOME} \
        && tar -z -x -f /tmp/nifi-bin.tar.gz -C ${NIFI_HOME} --strip-components=1 \
        && rm /tmp/nifi-keys.txt \
        && sed -i -e "s|^nifi.ui.banner.text=.*$$|nifi.ui.banner.text=Docker NiFi ${NIFI_VERSION}|" ${NIFI_HOME}/conf/nifi.properties \
        && groupadd nifi \
        && useradd -r -g nifi nifi \
        && bash -c "mkdir -p ${NIFI_HOME}/{database_repository,flowfile_repository,content_repository,provenance_repository}" \
        && chown nifi:nifi -R ${NIFI_HOME}

RUN mkdir -p /opt/data/scripts \
	&& mkdir /opt/data/schemas \
	&& mkdir /opt/data/in \
	&& mkdir /opt/data/out
COPY scripts /opt/data/scripts
COPY schemas /opt/data/schemas
COPY templates ${NIFI_HOME}/conf/templates/
RUN chown nifi:nifi -R /opt/data \
	&& chown -R nifi:nifi ${NIFI_HOME}/conf/templates

# Increase the memory from 512MB to 2GB
RUN sed -i -- 's/Xmx512m/Xmx2g/' /opt/nifi/conf/bootstrap.conf

# These are the volumes (in order) for the following:
# 1) user access and flow controller history
# 2) FlowFile attributes and current state in the system
# 3) content for all the FlowFiles in the system
# 4) information related to Data Provenance
# You can find more information about the system properties here - https://nifi.apache.org/docs/nifi-docs/html/administration-guide.html#system_properties
VOLUME ["${NIFI_HOME}/database_repository", \
        "${NIFI_HOME}/flowfile_repository", \
        "${NIFI_HOME}/content_repository", \
        "${NIFI_HOME}/provenance_repository"]

# Open port 8081 for the HTTP listen
USER nifi
WORKDIR ${NIFI_HOME}
EXPOSE 8080 8081
CMD ["bin/nifi.sh", "run"]
