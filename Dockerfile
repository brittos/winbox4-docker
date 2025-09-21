FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common ca-certificates apt-transport-https && \
    add-apt-repository universe && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      xvfb x11vnc fluxbox \
      libx11-dev libxtst-dev curl unzip \
      libxcb-glx0 libxcb-dri3-0 libxrender1 libxrandr2 libxfixes3 libxcursor1 libxi6 \
      libgl1 libgl1-mesa-dri libglx-mesa0 libegl1-mesa \
      libfreetype6 libfontconfig1 fonts-dejavu-core \
      libxkbcommon0 libxkbcommon-x11-0 \
      libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-render-util0 libxcb-render0 libxcb-shape0 libxcb-xkb1 \
      locales libxcb-cursor0 libxcb-xinerama0 && \
    locale-gen en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    DISPLAY=:1

WORKDIR /winbox

COPY start-winbox.sh .
RUN chmod +x /winbox/start-winbox.sh
RUN curl -L -o /winbox/WinBox_Linux.zip https://download.mikrotik.com/routeros/winbox/4.0beta30/WinBox_Linux.zip
RUN unzip /winbox/WinBox_Linux.zip -d /winbox && rm /winbox/WinBox_Linux.zip
RUN chmod +x /winbox/WinBox

CMD ["/bin/bash", "/winbox/start-winbox.sh"]