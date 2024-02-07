ARG REF \
    REPOSITORY="autodarts/releases"

###Build
FROM --platform=${BUILDPLATFORM} alpine:latest AS build
ARG REF \
    BUILDPLATFORM \
    TARGETPLATFORM \
    REPOSITORY

WORKDIR /
RUN echo "I am running on ${BUILDPLATFORM}, building for ${TARGETPLATFORM}"  && \
    apk update && \
    apk add wget tar && \
    PLATFORM=$(echo ${TARGETPLATFORM} | cut -d'/' -f1) && \
    ARCH=$(echo ${TARGETPLATFORM} | cut -d'/' -f2) && \
        VERSION=$(echo ${REF} | sed -e 's/^v//') && \
    ASSETNAME="autodarts$VERSION.$PLATFORM-$ARCH.tar.gz" && \
    wget "https://github.com/$REPOSITORY/releases/download/${REF}/$ASSETNAME" && \
    tar -vxf $ASSETNAME && \
    rm $ASSETNAME

###Run
FROM alpine:latest

WORKDIR /usr/local/bin/autodarts
COPY --from=build /autodarts .
RUN chmod +x ./autodarts

#expose the autodarts port
EXPOSE 3180

CMD ["./autodarts"]
