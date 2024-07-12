#!/bin/bash
version="$1"

if [ -z "$version" ]; then
	version="dev"
fi

cd $HOME/src/miniPaint

docker buildx create --name multiarchbuilder --use --bootstrap

if [ "$version" = "latest" ]; then
        docker buildx build --push . \
		--platform linux/arm64 \
                -t "crockerish/minipaint:$version" \
		-t "crockerish/minipaint:4.14.2"
else
	docker buildx build --push . \
		--platform linux/arm64 \
  	        -t "crockerish/minipaint:$version"
fi

docker buildx rm multiarchbuilder
