ARG VERSION \
    REPOSITORY="autodarts/releases"

###Build
FROM --platform=${BUILDPLATFORM} alpine:latest AS build
ARG REF \
    BUILDPLATFORM \
    TARGETPLATFORM \
    REPOSITORY

WORKDIR /
RUN apk update && \
    apk add wget tar jq && \
    PLATFORM=$(echo ${TARGETPLATFORM} | cut -d'/' -f1) && \
    ARCH=$(echo ${TARGETPLATFORM} | cut -d'/' -f2) && \
    ASSETURL=$(wget -qO- "https://get.autodarts.io/detection/latest/${PLATFORM}/${ARCH}/RELEASES.json" | jq -r --arg VERSION "${VERSION}" '.releases[] | select(.version == $VERSION) | .url') && \
    wget "$ASSETURL" && \
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
