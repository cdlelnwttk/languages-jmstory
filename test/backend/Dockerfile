# Use official Node.js image as base
FROM node:16

# Create and set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy all files
COPY . .

# Expose port 3000
EXPOSE 3000

# Start server
CMD ["node", "server.js"]
