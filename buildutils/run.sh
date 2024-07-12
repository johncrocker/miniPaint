 #!/bin/bash
version="$1"
 
if [ -z "$version" ]; then
	version="dev"
fi

cd $HOME/src/miniPaint

docker buildx build . \
	-t "crockerish/minipaint:$version"

docker run -it --rm --network proxy --expose 8080 \
	--name minipaint "crockerish/minipaint:$version"
