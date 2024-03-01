# Stage 1: Build stage
FROM maven:3.8.4-openjdk-8 AS build
WORKDIR /app

# Copy only the POM file to cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the rest of the source code and build the application
COPY src src
RUN mvn package -DskipTests

# Stage 2: Runtime stage
FROM openjdk:8-jre-alpine
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/docker-java-app-example.jar .

# Set the shell to bash
RUN apk update && apk add bash

# Make port 8081 available to the world outside this container
EXPOSE 8080

# Run jar file when the container launches
CMD ["java", "-jar", "docker-java-app-example.jar"]

