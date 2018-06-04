FROM multimediabs/intellij-ultimate:latest

USER root

# tools
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --fix-missing --no-install-recommends \
        openjdk-8-jdk \
        openjdk-8-source \
        tzdata

# setup timezone
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

# force java version
RUN update-java-alternatives -s java-1.8.0-openjdk-amd64

# change volumes permissions
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

USER developer
