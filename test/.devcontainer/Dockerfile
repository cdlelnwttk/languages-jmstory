# Use a Node.js base image with the necessary version
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-18

# Install PostgreSQL client
RUN apt-get update && apt-get install -y postgresql-client

# Install additional dependencies if needed
RUN apt-get install -y curl vim

# Set the working directory
WORKDIR /workspace

# Copy project files into the container
COPY . /workspace

# Install backend and frontend dependencies
RUN npm install --prefix /workspace/backend
RUN npm install --prefix /workspace/frontend

# Expose ports for frontend (8080), backend (3000), and PostgreSQL (5432)
EXPOSE 8080 3000 5432

# Start the container with bash as default
CMD ["bash"]

 
