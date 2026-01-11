# #got this from docker hub, java 17
# FROM maven:3.9.9-eclipse-temurin-17

# # Set the working directory to organize application files.
# WORKDIR /app

# #Set the maven built jar file from local machine to /app and renaminig it to springbootdocker.jar
# COPY target/seasonal_job_matching-0.0.1-SNAPSHOT.jar /app/seasonaljobs.jar

# #Get rid of old jar and gets new one with updated code, can add -DskipTests if we want to avoid testing
# #if on ubuntu use RUN mvn clean package
# #RUN ./mvnw clean package 

# #Run jar files when docker contrainer starts
# ENTRYPOINT [ "java", "-jar", "seasonaljobs.jar" ]
# --- Stage 1: Build the JAR ---
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copy files. The logs proved that Heroku puts the source code directly here.
COPY . .

# Run the build. We don't need to 'cd' anywhere because pom.xml is in /app
RUN mvn clean package -DskipTests

# --- Stage 2: Run the JAR ---
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the JAR directly from the /app/target folder found in the logs
COPY --from=build /app/target/*.jar seasonaljobs.jar

ENTRYPOINT ["java", "-jar", "seasonaljobs.jar"]