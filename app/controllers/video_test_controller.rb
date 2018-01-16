class VideoTestController < ApplicationController
  def show
    @video = Video.find(params[:id])
    set_cloudfront_cookies
  end

  private

    def set_cloudfront_cookies
      signer = Aws::CloudFront::CookieSigner.new(
        key_pair_id: ENV["CLOUDFRONT_KEY_ID"],
        private_key: ENV["CLOUDFRONT_PRIVATE_KEY"]
      )

      url = "https://media.browzable.com/*"
      domain = 'browzable.com'
      cloudfront_cookies = signer.signed_cookie(url, policy: cookie_policy.to_json)

      cookies['CloudFront-Policy'] = {
        value: cloudfront_cookies['CloudFront-Policy'],
        domain: domain
      }
      cookies['CloudFront-Key-Pair-Id'] = {
        value: cloudfront_cookies['CloudFront-Key-Pair-Id'],
        domain: domain
      }
      cookies['CloudFront-Signature'] = {
        value: cloudfront_cookies['CloudFront-Signature'],
        domain: domain
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
