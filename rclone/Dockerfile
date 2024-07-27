# Use the official Ubuntu image as the base
FROM ubuntu:latest

# Set noninteractive installation mode
ENV DEBIAN_FRONTEND=noninteractive

# Update apt and install packages
RUN apt-get update && apt-get install -y \
	bash \
	curl \
	unzip \
	&& rm -rf /var/lib/apt/lists/*
	
# Download and install the latest rclone
RUN curl -O https://downloads.rclone.org/v1.67.0/rclone-v1.67.0-linux-amd64.zip \
	&& unzip rclone-v1.67.0-linux-amd64.zip \
	&& cd rclone-v1.67.0-linux-amd64 \
	&& cp rclone /usr/bin/ \
	&& chown root:root /usr/bin/rclone \
	&& chmod 755 /usr/bin/rclone

# Set the working directory to /app
WORKDIR /app

# Create the configuration directory
RUN mkdir -p /root/.config/rclone

# Declare and set default values for the build arguments
ARG RCLONE_CONFIG_TYPE
ARG RCLONE_CONFIG_PROVIDER
ARG RCLONE_CONFIG_ACCESS_KEY_ID
ARG RCLONE_CONFIG_SECRET_ACCESS_KEY
ARG RCLONE_CONFIG_ENDPOINT
ARG RCLONE_CONFIG_ACL
ARG BUCKET_NAME

# Set environment variables to be used in the runtime
ENV RCLONE_CONFIG_TYPE=${RCLONE_CONFIG_TYPE}
ENV RCLONE_CONFIG_PROVIDER=${RCLONE_CONFIG_PROVIDER}
ENV RCLONE_CONFIG_ACCESS_KEY_ID=${RCLONE_CONFIG_ACCESS_KEY_ID}
ENV RCLONE_CONFIG_SECRET_ACCESS_KEY=${RCLONE_CONFIG_SECRET_ACCESS_KEY}
ENV RCLONE_CONFIG_ENDPOINT=${RCLONE_CONFIG_ENDPOINT}
ENV RCLONE_CONFIG_ACL=${RCLONE_CONFIG_ACL}
ENV BUCKET_NAME=${BUCKET_NAME}

# Create the rclone config file using environment variables
RUN echo "[s3]\n\
type = ${RCLONE_CONFIG_TYPE}\n\
provider = ${RCLONE_CONFIG_PROVIDER}\n\
access_key_id = ${RCLONE_CONFIG_ACCESS_KEY_ID}\n\
secret_access_key = ${RCLONE_CONFIG_SECRET_ACCESS_KEY}\n\
endpoint = ${RCLONE_CONFIG_ENDPOINT}\n\
acl = ${RCLONE_CONFIG_ACL}\n\
" > /root/.config/rclone/rclone.conf

# Copy the upload script into the container
COPY upload.sh .

# Make sure the script is executable
RUN chmod +x upload.sh

# Set the script to run when the container starts
ENTRYPOINT ["./upload.sh"]