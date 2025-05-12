# Build the Docker image (replace 'context-mapper-app' if desired)
docker build -t context-mapper-app .

# Create an 'output' directory on your host machine (if it doesn't exist)
# This is where the generated files will appear.
mkdir -p output

# Create a temporary container
docker create --name temp-cm context-mapper-app

# Copy the files from the container's /app/src-gen to the host's output directory
docker cp temp-cm:/app/src-gen/. ./output/

# Remove the temporary container
docker rm temp-cm