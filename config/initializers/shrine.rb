require "shrine/storage/s3"

s3_options = {
  access_key_id:     ENV["EMBEDS_AWS_ACCESS_KEY_ID"],
  secret_access_key: ENV["EMBEDS_AWS_SECRET_ACCESS_KEY"],
  region:            "us-west-1",
  bucket:            "embed-videos",
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
  store: Shrine::Storage::S3.new(prefix: "store", upload_options: {acl:"public-read"},**s3_options)
}


Shrine.plugin :activerecord
Shrine.plugin :presign_endpoint
Shrine.plugin :upload_endpoint
Shrine.plugin :restore_cached_data
