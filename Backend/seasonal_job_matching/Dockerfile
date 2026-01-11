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

# Copy files. 
# If context is root, this copies Backend/seasonal...
# If context is subdir, this copies src/ pom.xml...
COPY . .

# --- DEBUG: Print file structure to logs ---
RUN echo "STRUCTURE BEFORE BUILD:" && ls -R /app

# Smart Build: Check where pom.xml is and run maven there
RUN if [ -f "/app/pom.xml" ]; then \
        echo "Context is SUBDIRECTORY. Building in /app"; \
        mvn clean package -DskipTests; \
    elif [ -f "/app/Backend/seasonal_job_matching/pom.xml" ]; then \
        echo "Context is ROOT. Moving to Backend folder"; \
        cd /app/Backend/seasonal_job_matching && mvn clean package -DskipTests; \
    else \
        echo "ERROR: Could not find pom.xml"; \
        exit 1; \
    fi

# --- Stage 2: Run the JAR ---
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the JAR. We use shell command to find it because we don't know the exact path
# (Docker COPY doesn't support complex wildcards easily, so we copy from the most likely spot or use a shell hack in Stage 1)

# HACK: In Stage 1, we will move the built jar to a known location so Stage 2 can find it easily
COPY --from=build /app/**/target/*.jar ./temp_jar_search/

# Flatten the jar to the final name
RUN find ./temp_jar_search -name "*.jar" -exec mv {} seasonaljobs.jar \;

ENTRYPOINT ["java", "-jar", "seasonaljobs.jar"]