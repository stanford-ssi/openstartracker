FROM ubuntu

RUN apt-get update

# deal with timezones (change to what suits your use case)
ENV TZ=America/New_York

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install tzdata

WORKDIR home

# need all of this to work (was missing some packages)
RUN apt-get install -y python3-scipy libopencv-dev python3-opencv \
                       swig python3-systemd git astrometry.net \
                       python3-astropy python3-pkgconfig \
                       python3-dev libpython3.7-dev libpython3.8-dev

# clone the repo
RUN git clone https://github.com/stanford-ssi/openstartracker.git

WORKDIR openstartracker/tests/
