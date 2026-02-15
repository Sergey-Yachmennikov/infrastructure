FROM docker:24

# Устанавливаем Maven и Java
RUN apk add --no-cache \
    openjdk21 \
    maven \
    curl \
    git

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk