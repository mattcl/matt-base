#!/bin/bash
set -x

echo "KITCHEN_DOCKER_SOCKET=$KITCHEN_DOCKER_SOCKET"

cd repo
kitchen test $suite

code=$?

kitchen destroy $suite

exit $code
