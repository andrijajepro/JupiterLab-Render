# Use the latest Ubuntu image
FROM ubuntu:latest

# Set keyboard layout selection as environment variable
ENV DEBIAN_FRONTEND=noninteractive

# Pre-select keyboard layout
RUN echo 'keyboard-configuration keyboard-configuration/layout select English (US)' | debconf-set-selections && \
    echo 'keyboard-configuration keyboard-configuration/layoutcode string us' | debconf-set-selections && \
    apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    xrdp \
    xfce4

# Set the working directory
WORKDIR /app

# Install JupyterLab
RUN pip3 install jupyterlab

# Expose port 8080 (JupyterLab) and port 3390 (XRDP)
EXPOSE 8080
EXPOSE 3390

# Configure XRDP to use XFCE desktop environment and start on port 3390
RUN echo xfce4-session > ~/.xsession && \
    echo startxfce4 > /etc/xrdp/startwm.sh

# Start XRDP service
CMD service xrdp start && jupyter lab --ip=0.0.0.0 --port=8080 --no-browser --allow-root --NotebookApp.token=''
EXPOSE 3390
