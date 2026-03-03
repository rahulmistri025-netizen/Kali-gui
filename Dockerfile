FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV VNC_PORT=5901
ENV NO_VNC_PORT=8080

# Update & install packages
RUN apt update && apt install -y \
    xfce4 xfce4-goodies \
    tightvncserver \
    novnc websockify \
    supervisor \
    kali-linux-default \
    dbus-x11 \
    && apt clean

# Create user
RUN useradd -m kali && echo "kali:kali" | chpasswd && adduser kali sudo

# Setup VNC password
USER kali
RUN mkdir -p /home/kali/.vnc && \
    echo "kali" | vncpasswd -f > /home/kali/.vnc/passwd && \
    chmod 600 /home/kali/.vnc/passwd

USER root

# Copy startup files
COPY start.sh /start.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
