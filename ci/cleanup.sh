#!/bin/bash
set -x

echo $KITCHEN_DOCKER_SOCKET

cd repo
kitchen destroy $suite
