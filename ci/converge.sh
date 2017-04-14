#!/bin/bash
set -x

echo "KITCHEN_DOCKER_SOCKET=$KITCHEN_DOCKER_SOCKET"

cd repo
kitchen test $suite --no-color

code=$?

kitchen destroy $suite

exit $code
