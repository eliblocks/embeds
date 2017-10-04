class PromoteJobWorker
  include Sidekiq::Worker

  def perform(data)
    puts "\n\n\n"
    p data
    puts "\n\n\n"
    attacher = Shrine::Attacher.load(data)
    cached_file = attacher.get #=> #<Shrine::UploadedFile>

    p cached_file.id

    transcoder = Aws::ElasticTranscoder::Client.new(
      access_key_id: ENV['AWS_TRANSCODER_ACCESS_ID'],
      secret_access_key: ENV['AWS_TRANSCODER_ACCESS_SECRET'],
      region: "us-west-1")


    response = transcoder.create_job(pipeline_id: "1507048755947-jzlode",
                                    input: {
                                      key: cached_file.id
                                    },
                                    output: {
                                      key: "#{cached_file.id}.mp4",
                                      preset_id: "1351620000001-000001"
                                      })


    job_id = response.job.id


    completion = transcoder.read_job(id: job_id).job.status

    i = 0
    while i < 100 && completion != "Complete" do
      job = transcoder.read_job(id: job_id).job
      completion = job.status
      puts "#{i}: #{completion}"
      sleep 1
      i += 1
    end

    stored_data = {
                  "id" => job.output.key,
                  "storage" => "store",
                  "metadata" => {
                                  "size" => job.output.file_size,
                                  "filename" => cached_file.data["metadata"]["filename"],
                                  "mime_type" => "video/mp4",
                                  "duration" => job.output.duration
                                  }
                  }

    stored_file = ClipUploader::UploadedFile.new(stored_data)
    attacher.swap(stored_file)

  end
end

