FROM ubuntu:16.04

# utils
RUN apt-get update \
  && apt-get install -qq -y --fix-missing --no-install-recommends \
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
        openjdk-8-source \
	python-mysqldb \
	ssh \
	subversion \
	sudo \
	unzip \
	vim \
  && rm -rf /var/lib/apt/lists/*

# maven
RUN apt-get update \
  && apt-get install -qq -y --fix-missing --no-install-recommends maven \
  && rm -rf /var/lib/apt/lists/*
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
	libcanberra-gtk-module \
  && rm -rf /var/lib/apt/lists/*



# idea
RUN curl -fSL "https://download-cf.jetbrains.com/idea/ideaIU-2017.1.2.tar.gz" -o /tmp/idea.tar.gz \
  && cd /opt/ && tar zxf /tmp/idea.tar.gz && rm /tmp/idea.tar.gz \
  && ln -s /opt/idea-IU* /opt/idea \
  && ln -s /opt/idea/bin/idea.sh /usr/bin/idea


# use .IntelliJIdea directory instead of .IntelliJIdeaXXXX.X
RUN sed -i 's|^# idea.config.path=${user.home}/.IntelliJIdea/config|idea.config.path=${user.home}/.IntelliJIdea/config|' /opt/idea/bin/idea.properties
RUN sed -i 's|^# idea.system.path=${user.home}/.IntelliJIdea/system|idea.system.path=${user.home}/.IntelliJIdea/system|' /opt/idea/bin/idea.properties

COPY docker-entrypoint.sh /entrypoint.sh

# user developer
ENV USER=developer UID=1000 GID=1000
RUN groupadd -g ${GID} ${USER} && \
       useradd -u ${UID} -g ${GID} -G sudo -m ${USER} && \
       echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} && \
       chmod 0440 /etc/sudoers.d/${USER}

USER ${USER}
# liquidprompt rox
RUN liquidprompt_activate \
  && sed -i 's/^LP_ENABLE_TIME=0/LP_ENABLE_TIME=1/' /home/developer/.config/liquidpromptrc \
  && sed -i 's/^LP_HOSTNAME_ALWAYS=1/LP_HOSTNAME_ALWAYS=0/' /home/developer/.config/liquidpromptrc

# command
ENTRYPOINT ["/entrypoint.sh"]
WORKDIR /home/${USER}
CMD  ["idea"]
