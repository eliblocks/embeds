require 'aws-sdk-s3'
require 'aws-sdk-mediaconvert'

# headers = signature.headers
# headers['Content-Type'] = 'application/json'


# response = HTTParty.post(endpoint, headers: headers)

# puts response

# endpoint = response['endpoints'][0]["url"]
# puts endpoint

s3 = Aws::S3::Resource.new(region: 'us-west-1')

input_bucket = s3.bucket('browzable-movies-input')

# input_bucket.objects.each do |obj|
#   puts "#{obj.key} => #{obj.etag}"
# end

# puts "\noutput bucket:\n"

# output_bucket = s3.bucket('browzable-movies-output')

# output_bucket.objects.each do |obj|
#   puts "#{obj.key} => #{obj.etag}"
# end

input_key = "TearsOfSteel.mp4"

client = Aws::MediaConvert::Client.new

resp = client.describe_endpoints(max_results: 1)
endpoint = resp.endpoints[0].url

client = Aws::MediaConvert::Client.new(endpoint: endpoint)

job = {
  job_template: "arn:aws:mediaconvert:us-west-1:121996608541:jobTemplates/basic",
  queue: "arn:aws:mediaconvert:us-west-1:121996608541:queues/Default",
  role: "arn:aws:iam::121996608541:role/media-convert",
  settings: {
    inputs: [
      file_input: "s3://browzable-movies-input/BigBuckBunny.mp4"
    ]
  }
}

puts client.create_job(job)






