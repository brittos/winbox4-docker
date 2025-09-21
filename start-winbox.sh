#!/usr/bin/env bash
set -e

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export DISPLAY=:1

# garantir diretórios e symlink (corrige mounts que sobrescrevem /root)
mkdir -p /winbox/MikroTik/WinBox
mkdir -p /root/.local/share/MikroTik/WinBox
ln -sfn /winbox/MikroTik /root/.local/share/MikroTik

# criar arquivos vazios para evitar warnings do WinBox
touch /root/.local/share/MikroTik/WinBox/Addresses.cdb
touch /root/.local/share/MikroTik/WinBox/settings.cfg.viw2

XVFB_PID=""
WM_PID=""
VNC_PID=""

cleanup() {
  kill "$XVFB_PID" "$WM_PID" "$VNC_PID" 2>/dev/null || true
}
trap cleanup EXIT

# escolha de resolução via variável (padrão 1024x768x24)
Xvfb :1 -screen 0 1920x1080x24 -ac +extension GLX +render -noreset &
XVFB_PID=$!

sleep 1
fluxbox &
WM_PID=$!

# listen on all interfaces so host can connect (map port with -p 5900:5900)
#x11vnc -display :1 -nopw -listen 0.0.0.0 -xkb -ncache 10 -ncache_cr -forever -shared -rfbport 5900 -o /var/log/x11vnc.log &
x11vnc -display :1 -nopw -listen 0.0.0.0 -xkb -noncache -forever -shared -rfbport 5900 -o /var/log/x11vnc.log &
VNC_PID=$!

sleep 2

exec /winbox/WinBox
