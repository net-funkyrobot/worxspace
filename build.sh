set -euox

LATEST_VERSION=`git describe --tags --abbrev=0`

docker buildx use multiarch_builder || docker buildx create multiarch_builder --use --bootstrap
docker buildx build --push --platform=linux/arm64,linux/amd64 --tag cjsmith144/worxspace:latest --tag cjsmith144/worxspace:$LATEST_VERSION .