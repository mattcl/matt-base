#!/bin/bash
set -ex

pushd repo
version=$(chef exec ruby ci/extract_version.rb)
echo $version
berks package
popd

cp repo/cookbooks-*.tar.gz packaged-cookbook/${version}.tar.gz
