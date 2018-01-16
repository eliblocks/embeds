require 'aws-sdk-s3'
require 'aws-sdk-mediaconvert'
require 'httparty'

endpoint = 'https://mediaconvert.us-west-1.amazonaws.com/2017-08-29/endpoints'

# signer = Aws::Sigv4::Signer.new(
#   service: 'mediaconvert',
#   region: 'us-west-1',
#   access_key_id: ENV['AWS_ACCESS_KEY_ID'],
#   secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
# )

# signature = signer.sign_request(
#   http_method: 'POST',
#   url: endpoint,
#   headers: {}
# )

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
client = Aws::MediaConvert::Client.new(region: 'us-west-1')
resp = client.describe_endpoints(max_results: 1)


job = '{
  "Queue": "arn:aws:mediaconvert:us-west-1:121996608541:queues/Default",
  "Role": "arn:aws:iam::121996608541:role/media-convert",
  "Settings": {
    "OutputGroups": [
      {
        "Name": "Apple HLS",
        "Outputs": [
          {
            "ContainerSettings": {
              "Container": "M3U8",
              "M3u8Settings": {
                "AudioFramesPerPes": 4,
                "PcrControl": "PCR_EVERY_PES_PACKET",
                "PmtPid": 480,
                "PrivateMetadataPid": 503,
                "ProgramNumber": 1,
                "PatInterval": 0,
                "PmtInterval": 0,
                "Scte35Pid": 500,
                "TimedMetadataPid": 502,
                "VideoPid": 481,
                "AudioPids": [
                  482,
                  483,
                  484,
                  485,
                  486,
                  487,
                  488,
                  489,
                  490,
                  491,
                  492,
                  493,
                  494,
                  495,
                  496,
                  497,
                  498
                ]
              }
            },
            "Preset": "System-Avc_16x9_1080p_29_97fps_8500kbps",
            "VideoDescription": {
              "Width": 1920,
              "ScalingBehavior": "DEFAULT",
              "Height": 1080,
              "VideoPreprocessors": {
                "Deinterlacer": {
                  "Algorithm": "INTERPOLATE",
                  "Mode": "DEINTERLACE",
                  "Control": "NORMAL"
                }
              },
              "TimecodeInsertion": "DISABLED",
              "AntiAlias": "ENABLED",
              "Sharpness": 50,
              "CodecSettings": {
                "Codec": "H_264",
                "H264Settings": {
                  "InterlaceMode": "PROGRESSIVE",
                  "ParNumerator": 1,
                  "NumberReferenceFrames": 3,
                  "Syntax": "DEFAULT",
                  "FramerateDenominator": 1001,
                  "GopClosedCadence": 1,
                  "HrdBufferInitialFillPercentage": 90,
                  "GopSize": 90,
                  "Slices": 1,
                  "GopBReference": "DISABLED",
                  "HrdBufferSize": 12750000,
                  "SlowPal": "DISABLED",
                  "ParDenominator": 1,
                  "SpatialAdaptiveQuantization": "ENABLED",
                  "TemporalAdaptiveQuantization": "ENABLED",
                  "FlickerAdaptiveQuantization": "DISABLED",
                  "EntropyEncoding": "CABAC",
                  "Bitrate": 5800000,
                  "FramerateControl": "SPECIFIED",
                  "RateControlMode": "CBR",
                  "CodecProfile": "HIGH",
                  "Telecine": "NONE",
                  "FramerateNumerator": 30000,
                  "MinIInterval": 0,
                  "AdaptiveQuantization": "HIGH",
                  "CodecLevel": "LEVEL_4",
                  "FieldEncoding": "PAFF",
                  "SceneChangeDetect": "ENABLED",
                  "QualityTuningLevel": "MULTI_PASS_HQ",
                  "FramerateConversionAlgorithm": "DUPLICATE_DROP",
                  "UnregisteredSeiTimecode": "DISABLED",
                  "GopSizeUnits": "FRAMES",
                  "ParControl": "SPECIFIED",
                  "NumberBFramesBetweenReferenceFrames": 1,
                  "RepeatPps": "DISABLED"
                }
              },
              "AfdSignaling": "NONE",
              "DropFrameTimecode": "ENABLED",
              "RespondToAfd": "NONE",
              "ColorMetadata": "INSERT"
            },
            "AudioDescriptions": [
              {
                "AudioTypeControl": "FOLLOW_INPUT",
                "CodecSettings": {
                  "Codec": "AAC",
                  "AacSettings": {
                    "AudioDescriptionBroadcasterMix": "NORMAL",
                    "Bitrate": 128000,
                    "RateControlMode": "CBR",
                    "CodecProfile": "LC",
                    "CodingMode": "CODING_MODE_2_0",
                    "RawFormat": "NONE",
                    "SampleRate": 48000,
                    "Specification": "MPEG4"
                  }
                },
                "LanguageCodeControl": "FOLLOW_INPUT",
                "AudioType": 0
              }
            ],
            "NameModifier": "_hls_high"
          },
          {
            "ContainerSettings": {
              "Container": "M3U8",
              "M3u8Settings": {
                "AudioFramesPerPes": 4,
                "PcrControl": "PCR_EVERY_PES_PACKET",
                "PmtPid": 480,
                "PrivateMetadataPid": 503,
                "ProgramNumber": 1,
                "PatInterval": 0,
                "PmtInterval": 0,
                "Scte35Pid": 500,
                "TimedMetadataPid": 502,
                "VideoPid": 481,
                "AudioPids": [
                  482,
                  483,
                  484,
                  485,
                  486,
                  487,
                  488,
                  489,
                  490,
                  491,
                  492,
                  493,
                  494,
                  495,
                  496,
                  497,
                  498
                ]
              }
            },
            "Preset": "System-Avc_16x9_720p_29_97fps_5000kbps",
            "VideoDescription": {
              "Width": 1280,
              "ScalingBehavior": "DEFAULT",
              "Height": 720,
              "VideoPreprocessors": {
                "Deinterlacer": {
                  "Algorithm": "INTERPOLATE",
                  "Mode": "DEINTERLACE",
                  "Control": "NORMAL"
                }
              },
              "TimecodeInsertion": "DISABLED",
              "AntiAlias": "ENABLED",
              "Sharpness": 50,
              "CodecSettings": {
                "Codec": "H_264",
                "H264Settings": {
                  "InterlaceMode": "PROGRESSIVE",
                  "ParNumerator": 1,
                  "NumberReferenceFrames": 3,
                  "Syntax": "DEFAULT",
                  "FramerateDenominator": 1001,
                  "GopClosedCadence": 1,
                  "HrdBufferInitialFillPercentage": 90,
                  "GopSize": 90,
                  "Slices": 1,
                  "GopBReference": "DISABLED",
                  "HrdBufferSize": 7500000,
                  "SlowPal": "DISABLED",
                  "ParDenominator": 1,
                  "SpatialAdaptiveQuantization": "ENABLED",
                  "TemporalAdaptiveQuantization": "ENABLED",
                  "FlickerAdaptiveQuantization": "DISABLED",
                  "EntropyEncoding": "CABAC",
                  "Bitrate": 2350000,
                  "FramerateControl": "SPECIFIED",
                  "RateControlMode": "CBR",
                  "CodecProfile": "MAIN",
                  "Telecine": "NONE",
                  "FramerateNumerator": 30000,
                  "MinIInterval": 0,
                  "AdaptiveQuantization": "HIGH",
                  "CodecLevel": "LEVEL_3_1",
                  "FieldEncoding": "PAFF",
                  "SceneChangeDetect": "ENABLED",
                  "QualityTuningLevel": "MULTI_PASS_HQ",
                  "FramerateConversionAlgorithm": "DUPLICATE_DROP",
                  "UnregisteredSeiTimecode": "DISABLED",
                  "GopSizeUnits": "FRAMES",
                  "ParControl": "SPECIFIED",
                  "NumberBFramesBetweenReferenceFrames": 1,
                  "RepeatPps": "DISABLED"
                }
              },
              "AfdSignaling": "NONE",
              "DropFrameTimecode": "ENABLED",
              "RespondToAfd": "NONE",
              "ColorMetadata": "INSERT"
            },
            "AudioDescriptions": [
              {
                "AudioTypeControl": "FOLLOW_INPUT",
                "CodecSettings": {
                  "Codec": "AAC",
                  "AacSettings": {
                    "AudioDescriptionBroadcasterMix": "NORMAL",
                    "Bitrate": 96000,
                    "RateControlMode": "CBR",
                    "CodecProfile": "HEV1",
                    "CodingMode": "CODING_MODE_2_0",
                    "RawFormat": "NONE",
                    "SampleRate": 48000,
                    "Specification": "MPEG4"
                  }
                },
                "LanguageCodeControl": "FOLLOW_INPUT",
                "AudioType": 0
              }
            ],
            "NameModifier": "_hsl_mid"
          },
          {
            "ContainerSettings": {
              "Container": "M3U8",
              "M3u8Settings": {
                "AudioFramesPerPes": 4,
                "PcrControl": "PCR_EVERY_PES_PACKET",
                "PmtPid": 480,
                "PrivateMetadataPid": 503,
                "ProgramNumber": 1,
                "PatInterval": 0,
                "PmtInterval": 0,
                "Scte35Pid": 500,
                "TimedMetadataPid": 502,
                "VideoPid": 481,
                "AudioPids": [
                  482,
                  483,
                  484,
                  485,
                  486,
                  487,
                  488,
                  489,
                  490,
                  491,
                  492,
                  493,
                  494,
                  495,
                  496,
                  497,
                  498
                ]
              }
            },
            "Preset": "System-Avc_16x9_360p_29_97fps_1200kbps",
            "VideoDescription": {
              "Width": 640,
              "ScalingBehavior": "DEFAULT",
              "Height": 360,
              "VideoPreprocessors": {
                "Deinterlacer": {
                  "Algorithm": "INTERPOLATE",
                  "Mode": "DEINTERLACE",
                  "Control": "NORMAL"
                }
              },
              "TimecodeInsertion": "DISABLED",
              "AntiAlias": "ENABLED",
              "Sharpness": 50,
              "CodecSettings": {
                "Codec": "H_264",
                "H264Settings": {
                  "InterlaceMode": "PROGRESSIVE",
                  "ParNumerator": 1,
                  "NumberReferenceFrames": 3,
                  "Syntax": "DEFAULT",
                  "FramerateDenominator": 1001,
                  "GopClosedCadence": 1,
                  "HrdBufferInitialFillPercentage": 90,
                  "GopSize": 90,
                  "Slices": 1,
                  "GopBReference": "DISABLED",
                  "HrdBufferSize": 1800000,
                  "SlowPal": "DISABLED",
                  "ParDenominator": 1,
                  "SpatialAdaptiveQuantization": "ENABLED",
                  "TemporalAdaptiveQuantization": "ENABLED",
                  "FlickerAdaptiveQuantization": "DISABLED",
                  "EntropyEncoding": "CABAC",
                  "Bitrate": 560000,
                  "FramerateControl": "SPECIFIED",
                  "RateControlMode": "CBR",
                  "CodecProfile": "MAIN",
                  "Telecine": "NONE",
                  "FramerateNumerator": 30000,
                  "MinIInterval": 0,
                  "AdaptiveQuantization": "HIGH",
                  "CodecLevel": "LEVEL_3_1",
                  "FieldEncoding": "PAFF",
                  "SceneChangeDetect": "ENABLED",
                  "QualityTuningLevel": "MULTI_PASS_HQ",
                  "FramerateConversionAlgorithm": "DUPLICATE_DROP",
                  "UnregisteredSeiTimecode": "DISABLED",
                  "GopSizeUnits": "FRAMES",
                  "ParControl": "SPECIFIED",
                  "NumberBFramesBetweenReferenceFrames": 3,
                  "RepeatPps": "DISABLED"
                }
              },
              "AfdSignaling": "NONE",
              "DropFrameTimecode": "ENABLED",
              "RespondToAfd": "NONE",
              "ColorMetadata": "INSERT"
            },
            "AudioDescriptions": [
              {
                "AudioTypeControl": "FOLLOW_INPUT",
                "CodecSettings": {
                  "Codec": "AAC",
                  "AacSettings": {
                    "AudioDescriptionBroadcasterMix": "NORMAL",
                    "Bitrate": 96000,
                    "RateControlMode": "CBR",
                    "CodecProfile": "HEV1",
                    "CodingMode": "CODING_MODE_2_0",
                    "RawFormat": "NONE",
                    "SampleRate": 48000,
                    "Specification": "MPEG4"
                  }
                },
                "LanguageCodeControl": "FOLLOW_INPUT",
                "AudioType": 0
              }
            ],
            "NameModifier": "_hls_low"
          }
        ],
        "OutputGroupSettings": {
          "Type": "HLS_GROUP_SETTINGS",
          "HlsGroupSettings": {
            "ManifestDurationFormat": "INTEGER",
            "SegmentLength": 10,
            "TimedMetadataId3Period": 10,
            "CaptionLanguageSetting": "OMIT",
            "Destination": "s3://browzable-movies-output/",
            "TimedMetadataId3Frame": "PRIV",
            "CodecSpecification": "RFC_4281",
            "OutputSelection": "MANIFESTS_AND_SEGMENTS",
            "ProgramDateTimePeriod": 600,
            "MinSegmentLength": 0,
            "DirectoryStructure": "SINGLE_DIRECTORY",
            "ProgramDateTime": "EXCLUDE",
            "SegmentControl": "SEGMENTED_FILES",
            "ManifestCompression": "NONE",
            "ClientCache": "ENABLED",
            "StreamInfResolution": "INCLUDE"
          }
        }
      }
    ],
    "AdAvailOffset": 0,
    "Inputs": [
      {
        "AudioSelectors": {
          "Audio Selector 1": {
            "Offset": 0,
            "DefaultSelection": "DEFAULT",
            "ProgramSelection": 1
          }
        },
        "VideoSelector": {
          "ColorSpace": "FOLLOW"
        },
        "FilterEnable": "AUTO",
        "PsiControl": "USE_PSI",
        "FilterStrength": 0,
        "DeblockFilter": "DISABLED",
        "DenoiseFilter": "DISABLED",
        "TimecodeSource": "EMBEDDED",
        "FileInput": "s3://browzable-movies-input/inputkey"
      }
    ]
  }
}'

job.gsub!("inputkey", input_key)

# signature = signer.sign_request(
#   http_method: 'GET',
#   url: endpoint,
#   headers: {}
# )

# headers = signature.headers
# headers['Content-Type'] = 'application/json'

# endpoint = "#{endpoint}/jobs"
# response = HTTParty.post(endpoint, headers: headers)
# p response






test_params = { queue: "arn:aws:mediaconvert:us-west-1:121996608541:queues/Default",
                role: "arn:aws:iam::121996608541:role/media-convert" }

client.create_job(test_params)




