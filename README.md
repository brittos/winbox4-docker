# winbox-4 (Dockerized WinBox)

Containerized WinBox (MikroTik) running inside a headless X server + VNC.  
Includes Xvfb, fluxbox, x11vnc and a small start script that prepares the data directory and symlink.

## Structure
- Dockerfile — Ubuntu image with dependencies and start script
- start-winbox.sh — entrypoint: creates symlink, starts Xvfb, fluxbox, x11vnc and WinBox
- /winbox/WinBox — WinBox binary (downloaded during build)
- Persistent data: /winbox/MikroTik (recommended mount point)

## Build (Windows)
PowerShell:
docker build -t winbox:latest c:\tmp\winbox-4

CMD:
docker build -t winbox:latest "C:\tmp\winbox-4"

## Run (examples)
Run with VNC port exposed:
docker run --rm -it -p 5900:5900 winbox:latest

Set resolution via environment variable (default in script: 1920x1080x24):
docker run --rm -it -e WINBOX_RES=1024x768x24 -p 5900:5900 winbox:latest

Persist WinBox data (do not mount /root/.local/share directly):
docker run --rm -it -p 5900:5900 -v C:\my-data\MikroTik:/winbox/MikroTik winbox:latest

## How to connect
- Open a VNC client to `localhost:5900` (mapped port).
- WinBox runs inside the container at `/winbox/WinBox`.

## start-winbox.sh behavior
- Ensures `/winbox/MikroTik` exists and creates a symlink at `/root/.local/share/MikroTik`.
- Creates empty files required by WinBox to avoid warnings (Addresses.cdb, settings.cfg.viw2).
- Starts Xvfb (framebuffer), a window manager (fluxbox), x11vnc and runs the WinBox binary.
- Xvfb resolution can be controlled with WINBOX_RES or adjusted in the script.

## Persistence and volumes
- To preserve settings and address database, mount a host volume at `/winbox/MikroTik`.
- Example (Windows): `-v C:\my-data\MikroTik:/winbox/MikroTik`
- Avoid mounting directly to `/root/.local/share/MikroTik` as it may overwrite the symlink.

## Troubleshooting
- Qt xcb plugin errors: the image installs libxcb-cursor0 and libxcb-xinerama0. If more libxcb packages are reported, add them to the Dockerfile and rebuild.
- Locale/UTF-8: Dockerfile generates `en_US.UTF-8` and exports LANG/LC_ALL; keep this to avoid Qt issues.
- "exec start-winbox.sh: file not found": Dockerfile uses `CMD ["/bin/bash", "/winbox/start-winbox.sh"]` and the script must be executable (`chmod +x`).
- Cropped screen / resolution: increase WINBOX_RES or use a large framebuffer and adjust dynamically (optional, requires xdotool/xrandr).
- If using Windows volumes, verify paths/permissions and ensure the symlink was not overwritten.

## Customization
- Change resolution: set the WINBOX_RES environment variable or edit `start-winbox.sh`.
- Enable automatic window detection/resizing: install `xdotool` and `x11-xserver-utils` and adapt the script to detect the WinBox window and adjust the framebuffer.

## Rebuild after changes
After editing Dockerfile or start-winbox.sh:
docker build -t winbox:latest c:\tmp\winbox-4

## License / Notice
This repository only packages the WinBox binary downloaded from MikroTik's website; respect the original software license and terms of use.
```// filepath: c:\tmp\winbox-4\README.md
# winbox-4 (Dockerized WinBox)

Containerized WinBox (MikroTik) running inside a headless X server + VNC.  
Includes Xvfb, fluxbox, x11vnc and a small start script that prepares the data directory and symlink.

## Structure
- Dockerfile — Ubuntu image with dependencies and start script
- start-winbox.sh — entrypoint: creates symlink, starts Xvfb, fluxbox, x11vnc and WinBox
- /winbox/WinBox — WinBox binary (downloaded during build)
- Persistent data: /winbox/MikroTik (recommended mount point)

## Build (Windows)
PowerShell:
docker build -t winbox:latest c:\tmp\winbox-4

CMD:
docker build -t winbox:latest "C:\tmp\winbox-4"

## Run (examples)
Run with VNC port exposed:
docker run --rm -it -p 5900:5900 winbox:latest

Set resolution via environment variable (default in script: 1920x1080x24):
docker run --rm -it -e WINBOX_RES=1024x768x24 -p 5900:5900 winbox:latest

Persist WinBox data (do not mount /root/.local/share directly):
docker run --rm -it -p 5900:5900 -v C:\my-data\MikroTik:/winbox/MikroTik winbox:latest

## How to connect
- Open a VNC client to `localhost:5900` (mapped port).
- WinBox runs inside the container at `/winbox/WinBox`.

## start-winbox.sh behavior
- Ensures `/winbox/MikroTik` exists and creates a symlink at `/root/.local/share/MikroTik`.
- Creates empty files required by WinBox to avoid warnings (Addresses.cdb, settings.cfg.viw2).
- Starts Xvfb (framebuffer), a window manager (fluxbox), x11vnc and runs the WinBox binary.
- Xvfb resolution can be controlled with WINBOX_RES or adjusted in the script.

## Persistence and volumes
- To preserve settings and address database, mount a host volume at `/winbox/MikroTik`.
- Example (Windows): `-v C:\my-data\MikroTik:/winbox/MikroTik`
- Avoid mounting directly to `/root/.local/share/MikroTik` as it may overwrite the symlink.

## Troubleshooting
- Qt xcb plugin errors: the image installs libxcb-cursor0 and libxcb-xinerama0. If more libxcb packages are reported, add them to the Dockerfile and rebuild.
- Locale/UTF-8: Dockerfile generates `en_US.UTF-8` and exports LANG/LC_ALL; keep this to avoid Qt issues.
- "exec start-winbox.sh: file not found": Dockerfile uses `CMD ["/bin/bash", "/winbox/start-winbox.sh"]` and the script must be executable (`chmod +x`).
- Cropped screen / resolution: increase WINBOX_RES or use a large framebuffer and adjust dynamically (optional, requires xdotool/xrandr).
- If using Windows volumes, verify paths/permissions and ensure the symlink was not overwritten.

## Customization
- Change resolution: set the WINBOX_RES environment variable or edit `start-winbox.sh`.
- Enable automatic window detection/resizing: install `xdotool` and `x11-xserver-utils` and adapt the script to detect the WinBox window and adjust the framebuffer.

## Rebuild after changes
After editing Dockerfile or start-winbox.sh:
docker build -t winbox:latest c:\tmp\winbox-4

## License / Notice
This repository only packages the WinBox binary downloaded from MikroTik's website; respect the original software license and terms of use.
