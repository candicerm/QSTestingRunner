FROM openjdk:8u212-jre-alpine3.9

RUN apk update && apk add tzdata
RUN apk add --no-cache wkhtmltopdf
RUN apk --no-cache add msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f
RUN ls /usr/share/zoneinfo && \
	cp /usr/share/zoneinfo/America/New_York /etc/localtime && \
	echo "America/New_York" >  /etc/timezone && \
	cd /

# Workspace
WORKDIR /print

# Add files
ADD workspace/QSUITEST_RUNNER 			/print

ENTRYPOINT dos2unix printreport && ./printreport