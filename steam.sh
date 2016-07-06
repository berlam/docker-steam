#!/bin/sh
GENERAL="
-v /etc/localtime:/etc/localtime:ro \
-v /etc/machine-id:/etc/machine-id:ro \
-v /etc/passwd:/etc/passwd:ro \
-v /etc/shadow:/etc/shadow:ro \
-v /etc/sudoers.d:/etc/sudoers.d:ro \
--user=$(id -u) \
--ipc='host' \
--net='host' \
"
STORAGE="
-v $HOME/steam:/home/steam \
"
GRAPHIC="
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
-e DISPLAY=$DISPLAY \
$(find /dev/dri/ -type c | sed 's/^/--device /') \
"
SOUND="
-v /etc/asound.conf:/etc/asound.conf \
$(find /dev/snd/ -type c | sed 's/^/--device /') \
"
docker run -d --security-opt=seccomp:unconfined --name="steam" $GENERAL $STORAGE $GRAPHIC $SOUND berla/steam
