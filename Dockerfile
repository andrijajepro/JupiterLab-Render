# Use the latest Ubuntu image
FROM ubuntu:latest

# Update and install required packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    xvfb \
    xvnc4viewer \
    supervisor \
    net-tools

# Set the working directory
WORKDIR /app

# Install JupyterLab
RUN pip3 install jupyterlab

# Expose ports for JupyterLab and VNC
EXPOSE 8080 80

# Configure supervisord
RUN mkdir -p /var/log/supervisor

# Create supervisord.conf
RUN echo "[supervisord]\n\
nodaemon=true\n\n\
[program:xvnc]\n\
command=/usr/bin/Xvnc :1 -geometry 1024x768 -depth 24 -ac -auth /root/.Xauthority -rfbport 80\n\n\
[program:jupyterlab]\n\
command=jupyter lab --ip=0.0.0.0 --port=8080 --no-browser --allow-root --NotebookApp.token=''" > /etc/supervisor/conf.d/supervisord.conf

# Start supervisord which will manage our services
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
