# 1. Use a lightweight base image with OpenJDK 24
FROM eclipse-temurin:24-jdk-alpine

# 2. Install essential packages: Graphviz for diagrams, Maven for builds
RUN apk add --no-cache graphviz maven tree

# 3. Set the working directory in the container
WORKDIR /app

# 4. Copy Maven wrapper files first.
# This allows leveraging Docker cache effectively if only source code changes later.
COPY .mvn/ .mvn/
COPY mvnw ./
COPY mvnw.cmd ./

# 5. Make the Maven wrapper script executable
RUN chmod +x mvnw

# 6. Copy the pom.xml file
COPY pom.xml .

# 7. Download project dependencies using the Maven wrapper.
# This ensures the build uses the project-defined Maven version and configurations.
# It also helps in caching dependencies if pom.xml or wrapper files haven't changed.
RUN ./mvnw dependency:resolve

# 8. Copy the source code into the container
COPY src src/

# 9. Build the application using the Maven wrapper.
# This step should compile your code and create necessary artifacts (e.g., a JAR in /app/target/).
# It's assumed that your build process or the application itself is configured
# to place generated files (e.g., from context mapping) into the 'src-gen' directory.
RUN ./mvnw clean package

# 10. Declare the 'src-gen' directory as a volume.
# When the container runs, this directory can be mapped to a directory on the host (e.g., 'output').
# Any files written by your application to '/app/src-gen' will appear in the host's mapped directory.
VOLUME /app/src-gen

# 11. Define the default command to run when the container starts.
# This command should execute your application in a way that it generates the required files in '/app/src-gen'.
#
# !!! IMPORTANT !!!
# You MUST replace 'your-final-jar-name.jar' with the actual name of the
# executable JAR file produced by the './mvnw clean package' command.
# This JAR is typically located in the '/app/target/' directory.
# For example, if your POM.xml produces 'target/my-context-mapper-1.0.jar', the command would be:
# CMD ["java", "-jar", "target/my-context-mapper-1.0.jar"]
#
# If your application generates files directly as part of a Maven goal (e.g., during 'mvn package'
# or a specific plugin execution) and doesn't require a separate run command,
# you might adjust or remove this CMD. However, the request to "run the docker and check output"
# implies an explicit run step generates the files.
# CMD ["java", "-jar", "target/your-final-jar-name.jar"]
