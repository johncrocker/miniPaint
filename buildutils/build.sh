#!/bin/bash
version="$1"

if [ -z "$version" ]; then
	version="dev"
fi

cd $HOME/src/miniPaint

docker buildx build . \
	-t "crockerish/minipaint:$version"
