# Backend (Node.js)
# Use an official Node runtime as a parent image
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json to the container
COPY backend/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the backend files into the container
COPY backend/ .

# Expose port 5000
EXPOSE 5000

# Command to run the server
CMD ["node", "server.js"]
