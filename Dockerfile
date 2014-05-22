
# docker build -t $USER/ros-hydro .
# xhost +
# docker run -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 -i -t $USER/ros-hydro /usr/bin/byobu
# docker run --rm -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 -v /home/mandeep/docker-shared:/mnt -v /dev/video0:/dev/video0 --lxc-conf='lxc.cgroup.devices.allow = c 81:* rwm' -i -t opencog/ros-hydro /bin/bash
# docker run --rm -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 -v /home/mandeep/docker-shared:/mnt -v /dev/video0:/dev/video0 --lxc-conf='lxc.cgroup.devices.allow = c 81:* rwm' --lxc-conf='lxc.mount.entry = /dev/video0 dev/video0 none bind,optional,create=file' -i -t opencog/ros-hydro /bin/bash
# xhost + is stupid and dangerous, so please run 'xhost -' after launching apps 
# camorama -d /dev/video0
# docker export $USER/ros-hydro | gzip -c > /media/lenovo_mandeep/ros-hydro.tgz
# docker import $USER/ros-hydro < /media/lenovo_mandeep/ros-hydro.tgz
# echo 'DOCKER_OPTS="-H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock"' \
# | sudo tee -a /etc/default/docker 

FROM ubuntu:12.04
MAINTAINER Mandeep Singh Bhatia "mandeep.singh.bhatia@gmail.com"

RUN echo "deb http://packages.ros.org/ros/ubuntu precise main" > /etc/apt/sources.list.d/ros-latest.list && \
	apt-get -y update && \
    apt-get -y install python-software-properties wget byobu
RUN wget http://packages.ros.org/ros.key -O - | apt-key add - && \
    apt-get -y update 
RUN apt-get -y install ros-hydro-ros-base ros-hydro-rqt-common-plugins
RUN apt-get -y install ros-hydro-robot ros-hydro-viz
RUN apt-get -y install ros-hydro-mobile ros-hydro-perception ros-hydro-simulators
RUN apt-get -y install camorama

RUN rosdep init
RUN rosdep update
RUN echo "source /opt/ros/hydro/setup.bash" >> ~/.bashrc
ENV DISPLAY "0:0"
CMD /bin/bash
