#!/bin/bash
version="$1"

if [ -z "$version" ]; then
	version="dev"
fi

cd $HOME/src/miniPaint

docker buildx create --name multiarchbuilder --use --bootstrap

docker buildx build --push . \
        --platform linux/arm64 \
        -t "crockerish/minipaint:$version"

docker buildx rm multiarchbuilder
