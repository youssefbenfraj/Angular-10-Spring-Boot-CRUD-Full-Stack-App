# Use a base image that includes Maven and OpenJDK 17
FROM maven:3.8.3-openjdk-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml file to the container
COPY pom.xml .

# Download the project dependencies
RUN mvn dependency:go-offline

# Copy the project source code to the container
COPY src ./src

# Build the application
RUN mvn package -DskipTests

# Use a lightweight base image for running the application
FROM openjdk:17-jdk-slim
# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the build stage to the container
COPY --from=build /app/target/*.jar app.jar

# Set up MySQL
RUN apt-get update && apt-get install -y mysql-server && apt-get clean
RUN service mysql start && mysql -u root -e "CREATE DATABASE employee_management_system"

# Expose MySQL port
EXPOSE 3306

# Set environment variables
ENV MYSQL_DATABASE=employee_management_system
ENV MYSQL_USER=root
ENV MYSQL_PASSWORD=root
ENV MYSQL_ROOT_PASSWORD=root

# Specify the command to run your application
CMD ["java", "-jar", "app.jar"]
