arg IMG=node:14.15.4-alpine
from ${IMG}

add watchman /tmp/watchman
workdir /tmp/watchman
run apk add shadow alpine-sdk && addgroup root abuild
run abuild -F deps && \
  abuild -F unpack && \
  abuild -F build && \
  abuild-keygen -n -a -i && \
  abuild -F rootpkg
