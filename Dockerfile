# Use the latest Ubuntu image
FROM ubuntu:latest

# Update the package lists and install required packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    xvfb \
    xvnc4viewer \
    net-tools

# Set the working directory
WORKDIR /app

# Install JupyterLab
RUN pip3 install jupyterlab

# Expose ports for JupyterLab and VNC
EXPOSE 8080 80

# Start Xvfb, Xvnc, and JupyterLab
CMD Xvfb :1 -screen 0 1024x768x24 & \
    x11vnc -display :1 -bg -nopw -listen localhost -xkb -forever & \
    jupyter lab --ip=0.0.0.0 --port=8080 --no-browser --allow-root --NotebookApp.token=''
