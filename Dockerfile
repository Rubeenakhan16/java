# Use an official OpenJDK runtime as a parent image
FROM openjdk:8-jre-alpine

# Set the working directory to /app
WORKDIR /app

# Copy the fat jar into the container at /app
COPY target/docker-java-app-example.jar /app/

# Set the shell to bash
RUN apk update && apk add bash

# Make port 8081 available to the world outside this container
EXPOSE 8081

# Run jar file when the container launches
CMD ["java", "-jar", "docker-java-app-example.jar"]
