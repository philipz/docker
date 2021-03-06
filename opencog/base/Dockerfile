# For creating images with all the dependencies for development installed.
#
# docker build --no-cache -t opencog/opencog-deps .

FROM ubuntu:14.04
MAINTAINER David Hart "dhart@opencog.org"

RUN apt-get update ; apt-get -y upgrade ; apt-get -y autoclean
RUN apt-get -y install software-properties-common wget rlwrap telnet netcat-openbsd

# Install repositories and dependencies
ADD https://raw.githubusercontent.com/opencog/opencog/master/scripts/ocpkg \
    /tmp/install-dependencies-trusty
RUN chmod +x /tmp/install-dependencies-trusty && /tmp/install-dependencies-trusty

# Link Parser -- changes often
# Download the current released version of link-grammar.
# The wget gets the latest version w/ wildcard
RUN wget -r --no-parent -nH --cut-dirs=2 http://www.abisource.com/downloads/link-grammar/current/
RUN tar -zxf current/link-grammar-5*.tar.gz
RUN rm -r current
RUN (cd link-grammar-5.*/; mkdir build; cd build; ../configure; make -j$(nproc); make install; ldconfig)

# Environment Variables
## Set Locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Create and switch user. The user is privileged with no password required
RUN adduser --disabled-password --gecos "OpenCog Developer" opencog
RUN adduser opencog sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER opencog
WORKDIR /home/opencog

# Setup the workspace
## Dont't mount host volumes to opencog's home directory inside the container,
## if you do you want find the contents copied below
COPY /scripts/ /home/opencog
RUN sudo chown -R opencog:opencog * .* ; sudo chmod u+x configure-database.sh

# Defaults
## cogserver shell ports
EXPOSE 17001 18001

## REST api
EXPOSE 5000

## ports on which OpenCog's unity3d game communicates with opencog_embodiment
### port from opencog's embodiment code
EXPOSE 16313
### ports from the unity3d game code
EXPOSE 16315 16312

## Default postgresql port
EXPOSE 5432

## Default RelEx & RelEx2Logic port
EXPOSE 4444

## Default ZMQ port
EXPOSE 5563

# Docker defaults
# CMD bash for maintenance only
# ENTRYPOINT should be an application like distcc or buildbot or cogserver
CMD bash

# For images built on this
ONBUILD USER root
