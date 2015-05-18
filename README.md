## Overview
Create slug from build directory and environment

- Tar build directory
- Write environment variables to env.json
- Append to tar
- Upload to S3 bucket

## Testing
- In the build directory
  - Add a file called 'Slugify' and implements three functions:
    - slugify: turns build directory into slug
    - upload: uploads slug to location
    - cleanup: cleans up
  - Add this buildpack repository to .buildpacks
- Create Heroku application
  - Set config variables
    - ```AWS_ACCESS_KEY```
    - ```AWS_SECRET_KEY```
    - ```AWS_SLUG_BUCKET```
    - ```NODE_ENV=production```
  - Add heroku-buildpack-multi
    - ```heroku config:add BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi.git```
- Push to heroku master
- Verify that correct tar is uploaded to S3