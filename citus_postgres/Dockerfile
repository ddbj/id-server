# This Dockerfile is form  https://hub.docker.com/r/citusdata/membership-manager/dockerfile
# add bash
# manager.py is form https://github.com/citusdata/membership-manager.git

FROM python:3-alpine


RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

RUN apk update

RUN apk add --no-cache \
            --virtual psycodeps \
        gcc \
        bash \
        musl-dev \
        postgresql-dev \
        python3-dev && \
    pip install docker psycopg2 && \
    apk add --no-cache libpq && \
    apk del psycodeps

ADD manager.py /

# the manager creates a file when ready to consume events
HEALTHCHECK --interval=1s --start-period=1s CMD /bin/sh -c 'test -f /manager-ready'


# -u necessary to flush logging to docker in a timely manner
CMD [ "python", "-u", "./manager.py"]
