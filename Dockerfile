FROM alpine:3.9

ENV LANG C.UTF-8

ENV JAVA_ALPINE_VERSION 8.242.08-r0

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

RUN set -x \
 && { \
    		echo '#!/bin/sh'; \
    		echo 'set -e'; \
    		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    	} > /usr/local/bin/docker-java-home \
 && chmod +x /usr/local/bin/docker-java-home \
 && apk add --no-cache openjdk8="$JAVA_ALPINE_VERSION" \
 && [ "$JAVA_HOME" = "$(docker-java-home)" ]

CMD ["java", "-version" ]
