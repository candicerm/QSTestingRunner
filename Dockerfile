FROM openjdk:8u212-jre-alpine3.9

RUN apk update && apk add --no-cache wkhtmltopdf
RUN apk --no-cache add msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f

# Workspace
WORKDIR /print

# Add html files
ADD workspace/QSUITEST_RUNNER 			/print

ENTRYPOINT sh ./printreport