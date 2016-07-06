FROM ubuntu:xenial
MAINTAINER Matthias Berla

ENV DEBIAN_FRONTEND noninteractive
ENV SDL_AUDIODRIVER=alsa
ENV STEAM_RUNTIME=0
ENV HOME /home/steam

RUN dpkg --add-architecture i386
# Download dependencies
RUN apt-get update && apt-get install -yq wget curl zenity sudo python-apt xterm pciutils libgl1-mesa-dri:i386 libgl1-mesa-glx:i386 libc6:i386 libxtst6:i386 libxrandr2:i386 libglib2.0-0:i386 libgtk2.0-0:i386 libpulse0:i386 libgdk-pixbuf2.0-0:i386 libcurl4-openssl-dev:i386 libopenal1:i386 libsm6:i386 libice6:i386 libnss3:i386 libgconf-2-4:i386 libxss1:i386 libusb-1.0-0:i386 libnm-glib4:i386 libnm-util2:i386 libudev1:i386
# Download steam
RUN wget http://media.steampowered.com/client/installer/steam.deb
RUN sudo dpkg -i steam.deb && sudo apt-get install -f && sudo dpkg -i steam.deb
RUN adduser --disabled-password --gecos 'Steam' steam && adduser steam video && adduser steam audio && adduser steam voice
RUN echo 'steam ALL = NOPASSWD: ALL' > /etc/sudoers.d/steam && chmod 0440 /etc/sudoers.d/steam
# Link udev dependency as it is deprecated in newer ubuntu versions
# https://wiki.archlinux.org/index.php/Steam/Troubleshooting#Native_runtime:_steam.sh_line_756_Segmentation_fault
RUN sudo ln -s /lib/i386-linux-gnu/libudev.so.1 /lib/i386-linux-gnu/libudev.so.0

USER steam
VOLUME /home/steam

CMD ["steam"]
