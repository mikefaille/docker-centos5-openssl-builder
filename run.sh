#!/bin/bash

USAGE="Usage: $0 <buildname>-<version>"

ARG=${1}

error () {
    echo $USAGE
    echo "Error : $1"
    exit 1
}

if [[ ! ${ARG} ]]; then
    error "argument is not set"
fi



if [ ! -x build-scripts/build-${ARG}.sh ]; then
    error "build-scripts/build-${ARG}.sh don't exist'"
fi

mkdir -p rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}  2>/dev/null

docker build -t centos5-dev .

docker run -ti -v $(pwd)/build-scripts:/build-scripts -v $(pwd)/rpmbuild:/root/rpmbuild centos5-dev /build-scripts/build-${1}.sh
