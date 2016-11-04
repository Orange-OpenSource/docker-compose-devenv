#!/bin/bash
set -e

if [ "$1" = 'idea' ]; then
	sudo chown -R developer:developer /home/developer/
	# for idea update
	sudo chown -R developer:developer /opt/
fi

exec "$@"
