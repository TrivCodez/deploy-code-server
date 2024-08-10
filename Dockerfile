# Start from the code-server Debian base image
FROM codercom/code-server:4.9.0

# Use bash shell
ENV SHELL=/bin/bash

# Switch to root user
USER root

# Install unzip + rclone (support for remote filesystem)
RUN apt-get update && apt-get install unzip -y
RUN curl https://rclone.org/install.sh | bash

# Copy rclone tasks to /tmp, to potentially be used
COPY deploy-container/rclone-tasks.json /tmp/rclone-tasks.json

# Fix permissions for code-server
RUN chown -R coder:coder /home/coder/.local

# You can add custom software and dependencies for your environment below
# -----------

# Install a VS Code extension:
# Note: we use a different marketplace than VS Code. See [Reference Number 2](https://github.com/cdr/code-server/blob/main/docs/FAQ.md#differences-compared-to-vs-code)
# RUN code-server --install-extension esbenp.prettier-vscode

# Install apt packages:
# RUN apt-get install -y ubuntu-make

# Copy files: 
# COPY deploy-container/myTool /home/coder/myTool

# -----------

# Port
ENV PORT=8080

# Set the password
ENV PASSWORD=password

# Use our custom entrypoint script first
COPY deploy-container/entrypoint.sh /usr/bin/deploy-container-entrypoint.sh
ENTRYPOINT ["/usr/bin/deploy-container-entrypoint.sh"]
