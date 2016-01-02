#!/bin/sh
xhost local:root
docker run --rm --name="steam" \
	-v /etc/machine-id:/etc/machine-id:ro \
	-v /var/run/dbus:/var/run/dbus:rw \
	-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
	-v "$HOME/steam:/home/steam" \
	-e DISPLAY=unix${DISPLAY} \
	--device /dev/dri/card0 \
	--device /dev/snd:/dev/snd \
	--ipc="host" \
	--net="host" \
	--privileged=true \
	tianon/steam
