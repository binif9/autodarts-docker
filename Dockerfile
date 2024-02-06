ARG VERSION \
    BUILDPLATFORM \
    TARGETPLATFORM \
    REPOSITORY="autodarts/releases"

###Build
#if we want to compile, add a build step with the gcc image
# ARG GCC_VERSION=9.5.0
# ARG VERSION="0.22.0"
# ARG TARGETPLATFORM="linux/amd64"
#FROM gcc:latest AS build
#COPY . /usr/src/autodarts
#WORKDIR /usr/src/autodarts
#RUN gcc -o autodarts autodarts.c

#if we do not compile, download the executable
FROM --platform=${BUILDPLATFORM} alpine:latest AS build
ARG VERSION \
    BUILDPLATFORM \
    TARGETPLATFORM \
    REPOSITORY

WORKDIR /

RUN apk update && \
    apk add wget tar && \
    PLATFORM=$(echo ${TARGETPLATFORM} | cut -d'/' -f1) && \
    ARCH=$(echo ${TARGETPLATFORM} | cut -d'/' -f2) && \
    ASSETNAME="autodarts${VERSION}.${PLATFORM}-${ARCH}.tar.gz" && \
    wget "https://github.com/${REPOSITORY}/releases/download/v${VERSION}/$ASSETNAME" && \
    tar -vxf $ASSETNAME && \
    rm $ASSETNAME

###Run
FROM --platform=${TARGETPLATFORM} alpine:latest
ARG VERSION \
    BUILDPLATFORM \
    TARGETPLATFORM \
    REPOSITORY
WORKDIR /usr/local/bin/autodarts
COPY --from=build /autodarts .
RUN chmod +x ./autodarts

#expose the autodarts port
EXPOSE 3180

CMD ["./autodarts"]
