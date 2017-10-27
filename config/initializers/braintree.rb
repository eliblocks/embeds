Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = ENV["BRAINTREE_ID"]
Braintree::Configuration.public_key = ENV["BRAINTREE_PUBLIC_KEY"]
Braintree::Configuration.private_key = ENV["BRAINTREE_SECRET"]
