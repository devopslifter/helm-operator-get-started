#!/usr/bin/env bash

repository="devopslifter/podinfo"
branch="master"
version=""
commit="12345678"

while getopts :r:b:v: o; do
    case "${o}" in
        r)
            repository=${OPTARG}
            ;;
        b)
            branch=${OPTARG}
            ;;
        v)
            version=${OPTARG}
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${version}" ]; then
    image="${repository}:${branch}-${commit}"
    version="0.4.0"
else
    image="${repository}:${version}"
fi

echo ">>>> Building image ${image} <<<<"

docker build --build-arg GITCOMMIT=${commit} --build-arg VERSION=${version} -t ${image} -f Dockerfile.ci .

docker push ${image}
