#!/bin/bash

sudo chown developer.developer \
     /home/developer/.m2 \
     /home/developer/.m2/repository \
     /home/developer/.java \
     /home/developer/.IntelliJIdea
exec $@
