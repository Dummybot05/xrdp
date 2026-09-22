#!/bin/bash

service dbus start

mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

# Prevent script crash if PulseAudio system mode complains about running as root
pulseaudio --start --system --disallow-exit --disable-shm || true

# Create logs BEFORE tailing so the container doesn't exit prematurely
touch /var/log/xrdp.log /var/log/xrdp-sesman.log

service xrdp start

# Keep the container alive
tail -f /var/log/xrdp.log /var/log/xrdp-sesman.log