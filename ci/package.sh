#!/bin/bash
set -ex

pushd repo
verison=(chef exec ruby ci/extract_version.rb)
berks package
popd

cp repo/cookbooks-*.tar.gz packaged-cookbook/${version}.tar.gz
