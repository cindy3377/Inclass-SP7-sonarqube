# Stage 1: Build the app using Maven
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app

# Copy the pom.xml file to the container
COPY pom.xml /app/

# Copy the entire project to the container
COPY . /app/

# Package the application, skipping tests to speed up the build
RUN mvn clean package -DskipTests

# Stage 2: Run the app in a smaller image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the packaged jar file from the builder stage
COPY --from=builder /app/target/app.jar app.jar

# Expose port 8080 (or any port your app uses)
EXPOSE 8080

# Run the application using the command that launches your app
ENTRYPOINT ["java", "-jar", "app.jar"]
