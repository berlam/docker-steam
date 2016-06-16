#!/bin/sh
GENERAL="
-v /etc/localtime:/etc/localtime:ro \
-v /etc/machine-id:/etc/machine-id:ro \
--ipc='host' \
--net='host' \
"
STORAGE="
-v $HOME/steam:/home/steam \
"
GRAPHIC="
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
-v /etc/group:/etc/group:ro \
-v /etc/passwd:/etc/passwd:ro \
-v /etc/shadow:/etc/shadow:ro \
-v /etc/sudoers.d:/etc/sudoers.d:ro \
-e DISPLAY=$DISPLAY \
--user=$(id -u) \
$(find /dev/dri/ -type c | sed 's/^/--device /') \
"
SOUND="
-v /etc/asound.conf:/etc/asound.conf \
$(find /dev/snd/ -type c | sed 's/^/--device /') \
"
docker run --rm --security-opt=seccomp:unconfined --name="steam" $GENERAL $STORAGE $GRAPHIC $SOUND berla/steam
#docker run --rm --security-opt=seccomp:seccomp.json -it --name="steam" $GENERAL $STORAGE $GRAPHIC $SOUND tianon/steam /bin/bash
#docker run --rm -it --name="steam" $GENERAL $STORAGE $GRAPHIC $SOUND tianon/steam /bin/bash
