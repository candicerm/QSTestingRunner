FROM openjdk:8u212-jre-alpine3.9

RUN apk update && apk add --no-cache wkhtmltopdf
RUN apk --no-cache add msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f

# Workspace
WORKDIR /output

# Add html files
ADD workspace/QSUITEST_RUNNER 			/output

ENTRYPOINT sh ./printreport