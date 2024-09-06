# Use a base image with JDK 18 and Debian-based system
FROM openjdk:21-slim-buster

# Install necessary utilities
RUN apt-get update && apt-get install -y \
    findutils \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for Maven installation
ENV MAVEN_VERSION=3.9.9
ENV MAVEN_HOME=/usr/share/maven
ENV PATH="$MAVEN_HOME/bin:$PATH"

# Install Maven
RUN mkdir -p $MAVEN_HOME /usr/share/maven/ref \
  && curl -fsSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
  | tar -xzC $MAVEN_HOME --strip-components=1 \
  && ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn

# Copy your source code into the image
COPY ./ /app

# Set the working directory
WORKDIR /app

# Build your project and package it
RUN mvn clean package

# Set the working directory for the application
WORKDIR /app/target

# Use the correct command to find and rename the jar
RUN mv "$(find . -type f -name '*-jar-with-dependencies.jar')" app.jar

# Command to run your application
CMD ["java", "-jar", "/app/HelloWorldMaven.jar"]

