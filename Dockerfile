FROM openjdk:8u212-jre-alpine3.9

RUN apk update && apk add --no-cache wkhtmltopdf
RUN apk --no-cache add msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f

ARG JOB_NAME
ARG BUILD_NUMBER

# Workspace
WORKDIR /output/print

# Add html files
ADD ././jobs/${JOB_NAME}/builds/${BUILD_NUMBER}/archive/output 	/output

# Add printreport
ADD workspace/${JOB_NAME}/printreport 								/output/print

ENTRYPOINT sh ./printreport