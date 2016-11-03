FROM ubuntu:16.04

# utils
RUN apt-get update && apt-get install -qq -y --fix-missing --no-install-recommends \
	chromium-chromedriver \
	curl \
        dsh \
	file \
	git \
	git-flow \
	git-svn \
	htop \
	iputils-ping \
	kmod \
	less \
	language-pack-fr \
	liquidprompt \
        net-tools \
	openjdk-8-jdk \
	python-mysqldb \
	ssh \
	subversion \
	sudo \
	unzip \
	vim

# maven
RUN apt-get update && apt-get install -qq -y --fix-missing --no-install-recommends maven
RUN curl -fSL http://dl.bintray.com/jcgay/maven/com/github/jcgay/maven/color/maven-color-logback/1.6.0/maven-color-logback-1.6.0-bundle.tar.gz -o /tmp/maven-color-logback-1.6.0-bundle.tar.gz \
    && tar xvfz /tmp/maven-color-logback-1.6.0-bundle.tar.gz -C /usr/share/maven \
    && rm /tmp/maven-color-logback-1.6.0-bundle.tar.gz /usr/share/maven/lib/slf4j-simple*.jar

# lib for idea
RUN apt-get update && apt-get install -qq -y --fix-missing --no-install-recommends \
	software-properties-common \
	libxext-dev \
	libxrender-dev \
	libxtst-dev \
	libxslt1.1 \
	libgtk2.0-0 \
	libcanberra-gtk-module

# idea
RUN curl -fSL "http://download-cf.jetbrains.com/idea/ideaIU-2016.2.5.tar.gz" -o /tmp/idea.tar.gz
RUN cd /opt/ && tar zxf /tmp/idea.tar.gz
RUN ln -s /opt/idea-IU* /opt/idea
RUN ln -s /opt/idea/bin/idea.sh /usr/bin/idea

COPY docker-entrypoint.sh /entrypoint.sh

# user developer
ENV USER=developer UID=1000 GID=1000
RUN groupadd -g ${GID} ${USER} && \
       useradd -u ${UID} -g ${GID} -G sudo -m ${USER} && \
       echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} && \
       chmod 0440 /etc/sudoers.d/${USER}

USER ${USER}

COPY .bash_aliases /home/${USER}/.bash_aliases

# liquidprompt rox
RUN liquidprompt_activate
RUN sed -i 's/^LP_ENABLE_TIME=0/LP_ENABLE_TIME=1/' /home/developer/.config/liquidpromptrc
RUN sed -i 's/^LP_HOSTNAME_ALWAYS=1/LP_HOSTNAME_ALWAYS=0/' /home/developer/.config/liquidpromptrc

# command
ENTRYPOINT ["/entrypoint.sh"]
WORKDIR /home/${USER}
CMD  ["idea"]

