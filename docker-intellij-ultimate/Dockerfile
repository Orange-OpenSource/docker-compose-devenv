# Software Name : docker-compose-devenv
# Version: 1.0
# SPDX-FileCopyrightText: Copyright (c) 2020 Orange OBS SA
# SPDX-License-Identifier: MIT
#
# This software is distributed under the MIT License,
# the text of which is available at https://spdx.org/licenses/MIT.html
# or see the "license.txt" file for more details.
#
# Author: rudy remoissonnet rudy.remoissonnet@orange.com

FROM ubuntu:20.04

# utils
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --fix-missing --no-install-recommends \
        bash-completion \
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
	libxss1 \
	liquidprompt \
  	net-tools \
	ssh \
	subversion \
	sudo \
	unzip \
	vim \
  	bzip2 \
  	tree \
  	openjdk-11-jdk \
  	openjdk-11-source \
	maven \
	tzdata \
  && apt-get remove -y manpages manpages-dev \
  && apt-get remove -y make \
  && apt-get autoremove -y \
  && apt-get autoclean -y \
  && apt-get clean -y \
  && rm -rf /usr/share/locale/* \
  && rm -rf /var/cache/debconf/* \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /usr/share/doc/*


# lib for idea
RUN apt-get update && apt-get install -qq -y --fix-missing --no-install-recommends \
	software-properties-common \
	libxext-dev \
	libxrender-dev \
	libxtst-dev \
	libxslt1.1 \
	libgtk2.0-0 \
	libcanberra-gtk-module \
  && apt-get remove -y manpages manpages-dev \
  && apt-get remove -y make \
  && apt-get autoremove -y \
  && apt-get autoclean -y \
  && apt-get clean -y \
  && rm -rf /usr/share/locale/* \
  && rm -rf /var/cache/debconf/* \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /usr/share/doc/*

# idea
# chmod 777 is for IntelliJIdea update
RUN curl -fSL "https://download.jetbrains.com/idea/ideaIU-2021.3.1.tar.gz" -o /tmp/idea.tar.gz \
  && cd /opt/ && tar zxf /tmp/idea.tar.gz && rm /tmp/idea.tar.gz \
  && ln -s /opt/idea-IU* /opt/idea \
  && ln -s /opt/idea/bin/idea.sh /usr/bin/idea \
  && chmod 777 -R /opt/idea*

# use .IntelliJIdea directory instead of .IntelliJIdeaXXXX.X
RUN sed -i 's|^# idea.config.path=${user.home}/.IntelliJIdea/config|idea.config.path=${user.home}/.IntelliJIdea/config|' /opt/idea/bin/idea.properties \
	&& sed -i 's|^# idea.system.path=${user.home}/.IntelliJIdea/system|idea.system.path=${user.home}/.IntelliJIdea/system|' /opt/idea/bin/idea.properties \
	&& sed -i 's|^# idea.plugins.path=${idea.config.path}/plugins|idea.plugins.path=${user.home}/.IntelliJIdea/plugins|' /opt/idea/bin/idea.properties \
	&& sed -i 's|^# idea.log.path=${idea.system.path}/log|idea.log.path=${user.home}/.IntelliJIdea/logs|' /opt/idea/bin/idea.properties

# increase Inotify Watches Limit
RUN echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.d/60-jetbrains.conf


# user developer
ARG UID=1000
ARG GID=1000
ENV USER=developer UID=${UID} GID=${GID}
RUN groupadd -g ${GID} ${USER} && \
       useradd -u ${UID} -g ${GID} -G sudo -m ${USER} && \
       echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} && \
       chmod 0440 /etc/sudoers.d/${USER}

# run as developer
USER ${USER}


# liquidprompt rox
RUN liquidprompt_activate \
  && sed -i 's/^LP_ENABLE_TIME=0/LP_ENABLE_TIME=1/' /home/developer/.config/liquidpromptrc \
  && sed -i 's/^LP_HOSTNAME_ALWAYS=1/LP_HOSTNAME_ALWAYS=0/' /home/developer/.config/liquidpromptrc


# command
WORKDIR /home/${USER}
CMD  ["/bin/bash"]
