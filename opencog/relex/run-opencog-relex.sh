#! /bin/bash
#
# Run the docker container. Stop any previously running copies.
#
./stop.sh relex-opencog
docker run --name="relex-opencog" -p 4444:4444 \
   -w /home/Downloads/relex-master relex/relex /bin/sh opencog-server.sh

clear
