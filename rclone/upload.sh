#!/bin/bash
# Script to wait for a new file in /app/videos and upload it to Linode Object Storage using environment variables

upload_files() {
	for file in /app/videos/*; do
		if [ -f "$file" ]; then
			echo "Uploading $file..."
			rclone copy "$file" s3:$BUCKET_NAME
			if [ $? -eq 0 ]; then
				echo "Successfully uploaded: $file"
				echo "$(date): Successfully uploaded $file" >> /app/upload.log
				# Check if the file was modified more than 24 hours ago and delete it if true
				if [ $(find "$file" -mmin +1440) ]; then
					rm "$file"
					echo "Deleted $file"
				else
					echo "File $file not old enough to delete."
				fi
			else
				echo "Failed to upload: $file"
				echo "$(date): Failed to upload $file" >> /app/upload.log
			fi
		fi
	done
}

while true; do
	if [ "$(ls -A /app/videos)" ]; then
		upload_files
	else
		echo "No files to upload. Waiting..."
	fi
	sleep 60
done