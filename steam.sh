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
-e DISPLAY=$DISPLAY \
$(find /dev/dri/ -type c | sed 's/^/--device /') \
"
SOUND="
-v /etc/asound.conf:/etc/asound.conf \
$(find /dev/snd/ -type c | sed 's/^/--device /') \
"
docker run --rm --security-opt=seccomp:unconfined --name="steam" $GENERAL $STORAGE $GRAPHIC $SOUND berla/steam
