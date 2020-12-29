#!/bin/bash
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

sudo chown developer.developer \
     /home/developer/.m2 \
     /home/developer/.m2/repository \
     /home/developer/.java \
     /home/developer/.IntelliJIdea
exec $@
