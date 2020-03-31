FROM alpine:3.11.5

ENV LANG C.UTF-8

ENV JAVA_ALPINE_VERSION 11.0.5_p10-r0

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-11-openjdk/jre/bin:/usr/lib/jvm/java-11-openjdk/bin

RUN set -x \
 && { \
    		echo '#!/bin/sh'; \
    		echo 'set -e'; \
    		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    	} > /usr/local/bin/docker-java-home \
 && chmod +x /usr/local/bin/docker-java-home \
 && apk add --no-cache openjdk11="$JAVA_ALPINE_VERSION" \
 && [ "$JAVA_HOME" = "$(docker-java-home)" ]

CMD ["java", "--version" ]
