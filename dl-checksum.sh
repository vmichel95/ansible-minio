#!/usr/bin/env sh

MIRROR=https://dl.minio.io

# https://dl.minio.io/server/minio/release/linux-amd64/
SERVER_TS=2020-09-10T22-02-45Z

# https://dl.minio.io/client/mc/release/linux-amd64
CLIENT_TS=2020-09-03T00-08-28Z

dl()
{
    local appdom=$1
    local appname=$2
    local arch=$3
    local ts=$4
    local file=$appname.RELEASE.$ts.sha256sum
    local url=$MIRROR/$appdom/$appname/release/$arch/$file
    printf "        # %s\n" $url
    printf "        %s: sha256:%s\n" $arch `curl -sSL $url | awk '{print $1}'`
}


printf "      '%s':\n" $SERVER_TS
for platform in darwin-amd64 linux-amd64 windows-amd64
do
    dl server minio $platform $SERVER_TS
done

printf "      '%s':\n" $CLIENT_TS
for platform in darwin-amd64 linux-amd64 windows-amd64
do
    dl client mc $platform $CLIENT_TS
done


