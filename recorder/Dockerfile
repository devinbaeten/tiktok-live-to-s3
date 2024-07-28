FROM python:3.10-slim

# Install git
RUN apt-get update && apt-get install -y git ffmpeg jq && \
	ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime

# Clone the repository
WORKDIR /app
RUN git clone https://github.com/Michele0303/tiktok-live-recorder.git .

# Install Python dependencies
WORKDIR /app/src
RUN pip install --no-cache-dir -r requirements.txt

# Create the videos directory where output will be stored
RUN mkdir -p videos

ARG COOKIE
ARG TIMEZONE
ENV TZ=${TIMEZONE}

# Use jq to create the cookies.json file
RUN echo '{"sessionid_ss": "", "tt-target-idc": "useast2a"}' | \
	jq --arg sessionid_ss "$COOKIE" '.sessionid_ss = $sessionid_ss' > cookies.json

# Set the default command to run the script, using environment variable for the username
CMD ["sh", "-c", "python main.py -room_id $ROOM_ID -mode automatic -ffmpeg -output videos"]