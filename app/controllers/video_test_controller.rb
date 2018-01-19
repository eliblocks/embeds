class VideoTestController < ApplicationController
  def show
    @video = Video.find(params[:id])
  end

  private
    def set_cloudfront_cookies
      signer = Aws::CloudFront::CookieSigner.new(
        key_pair_id: ENV["CLOUDFRONT_KEY_ID"],
        private_key: ENV["CLOUDFRONT_PRIVATE_KEY"]
      )

      url = "https://*.browzable.com/*"

      cloudfront_cookies = signer.signed_cookie(url, policy: cookie_policy.to_json)

      cookies['CloudFront-Policy'] = {
        value: cloudfront_cookies['CloudFront-Policy'],
        domain: :all,
        expires: 1.days.from_now
      }
      cookies['CloudFront-Key-Pair-Id'] = {
        value: cloudfront_cookies['CloudFront-Key-Pair-Id'],
        domain: :all,
        expires: 1.days.from_now
      }
      cookies['CloudFront-Signature'] = {
        value: cloudfront_cookies['CloudFront-Signature'],
        domain: :all,
        expires: 1.days.from_now
      }
      cookies['Test-One'] = {
        value: 'something',
        domain: :all,
        expires: 1.years.from_now
      }
    end

    def cookie_policy
      {
        "Statement": [
          {
            "Resource":"https://media.browzable.com/*",
            "Condition":{
              "DateLessThan":{"AWS:EpochTime" => 1.days.from_now.to_i}
            }
          }
        ]
      }
    end
end
