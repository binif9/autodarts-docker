ARG REPOSITORY="autodarts/releases"

###Build
FROM --platform=${BUILDPLATFORM} alpine:latest AS build
ARG version \
    BUILDPLATFORM \
    TARGETPLATFORM \
    REPOSITORY

WORKDIR /
RUN echo "I am running on ${BUILDPLATFORM}, building for ${TARGETPLATFORM}"  && \
    apk update && \
    apk add wget tar && \
    PLATFORM=$(echo ${TARGETPLATFORM} | cut -d'/' -f1) && \
    ARCH=$(echo ${TARGETPLATFORM} | cut -d'/' -f2) && \
    ASSETNAME="autodarts${version}.$PLATFORM-$ARCH.tar.gz" && \
    wget "https://github.com/$REPOSITORY/releases/download/${version}/$ASSETNAME" && \
    tar -vxf $ASSETNAME && \
    rm $ASSETNAME

###Run
FROM alpine:latest

WORKDIR /usr/local/bin/autodarts
COPY --from=build /autodarts .
RUN echo "I am running on ${BUILDPLATFORM}, building for ${TARGETPLATFORM}" && \
    chmod +x ./autodarts

#expose the autodarts port
EXPOSE 3180

CMD ["./autodarts"]
