# Dockerfile

# Use an official Node.js image as the base image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port the app will run on
EXPOSE 3000

ENV DB_USER=your-username
ENV DB_PASSWORD=your-password
ENV DB_HOST=db
ENV DB_PORT=5432
ENV DB_DATABASE=your-database

# Start the application
CMD ["npm", "start"]
