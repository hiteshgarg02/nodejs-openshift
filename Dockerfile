FROM openshift/nodejs:latest
MAINTAINER garghitesh@ibm.com
EXPOSE 8080
COPY .s2i/bin /usr/local/s2i

LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i

CMD ["echo","please refer usage"]
