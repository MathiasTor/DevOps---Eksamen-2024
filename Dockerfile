# Stage 1: Build the application
FROM maven:3.8.6-eclipse-temurin-17 as builder

WORKDIR /app
COPY java_sqs_client/pom.xml .
COPY java_sqs_client/src ./src
RUN mvn clean package -DskipTests

# Stage 2: Minimal runtime image
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app
COPY --from=builder /app/target/imagegenerator-0.0.1-SNAPSHOT.jar /app/app.jar

# Set environment variable for SQS_QUEUE_URL
ENV SQS_QUEUE_URL="https://sqs.eu-west-1.amazonaws.com/244530008913/image-generator-queue"

# Use ENTRYPOINT to run the Java application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
