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
