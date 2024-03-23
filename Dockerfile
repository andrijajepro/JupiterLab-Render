# Use the latest Ubuntu image
FROM ubuntu:latest

# Update and install required packages
RUN apt-get update && apt-get install -y \
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
RUN echo xfce4-session > ~/.xsession
RUN echo startxfce4 > /etc/xrdp/startwm.sh

# Start JupyterLab on port 8080 without authentication
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8080", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
