# TikTok Live to S3
Automatically record TikTok Lives and sync them to a S3 bucket

Powered by [Docker](https://docker.com), [Michele0303/tiktok-live-recorder](https://github.com/Michele0303/tiktok-live-recorder), and [Rclone](https://rclone.org)

## Environment Variables

Store these in a .env file before building & running

| Variable | Usage |
| - | - |
| `TIKTOK_ROOM_ID` | `room_id`/`roomId` of the TikTok Live room you want to record. |
| `TIKTOK_COOKIE` | _(Optional)_ Use your own TikTok session cookie `sessionid_ss` from the web application if you run into access issues. |
| `S3_PROVIDER` | Your S3 Provider. [List](https://rclone.org/s3/) |
| `S3_ACCESS_KEY` | Your S3 Access Key |
| `S3_SECRET_KEY` | Your S3 Secret Key |
| `S3_ENDPOINT` | Your S3 Endpoint |
| `S3_BUCKET_NAME` | The Name of the S3 bucket you wish to store the videos in |
| `S3_ACL` | The ACL rule to apply for videos uploaded to the bucket |

## Deployment
Follow these steps to deploy this on your machine
1. Install Docker _(if using Docker Desktop, ensure it is running before proceeding)_
2. Clone this repository `git clone https://github.com/devinbaeten/tiktok-live-to-s3` and cd into it `cd tiktok-live-to-s3`
3. Build `docker-compose build` _(This will take a while)_
4. Run (as daemon) `docker-compose up -d`

## Troubleshooting
If you have issues with the TikTok recorder service, please refer to https://github.com/Michele0303/tiktok-live-recorder to troubleshoot any errors.

If you have issues with something unrelated to the recording service, open an issue here.
