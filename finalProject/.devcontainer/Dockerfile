FROM debian:latest

# Install GnuCOBOL and other tools
RUN apt-get update && apt-get install -y \
    open-cobol \
    vim \
    git && \
    apt-get clean

# Set working directory
WORKDIR /workspace
