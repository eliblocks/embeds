require 'aws-sdk'

Aws.config.update({
  region: 'us-west-1',
  credentials: Aws::Credentials.new(ENV['EMBEDS_AWS_ACCESS_KEY_ID'], ENV['EMBEDS_AWS_SECRET_ACCESS_KEY'])
})

s3 = Aws::S3::Client.new
resp = s3.list_objects(bucket: 'embeds-store', max_keys: 2)
p resp
