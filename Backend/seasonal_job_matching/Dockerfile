#got this from docker hub, java 17
FROM maven:3.9.9-eclipse-temurin-17

# Set the working directory to organize application files.
WORKDIR /app

#Set the maven built jar file from local machine to /app and renaminig it to springbootdocker.jar
COPY target/seasonal_job_matching-0.0.1-SNAPSHOT.jar /app/seasonaljobs.jar

#Get rid of old jar and gets new one with updated code
#RUN mvn clean package -DskipTests

#Run jar files when docker contrainer starts
ENTRYPOINT [ "java", "-jar", "seasonaljobs.jar" ]