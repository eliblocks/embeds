class Account < ApplicationRecord
  belongs_to :user


  def subtract_balance(play)
    new_balance = balance - play.duration
    update(balance: new_balance)
  end

  def image_id
    image.split('/')[1]
  end

  def image_version
    image.split('/')[0]
  end

  def self.cl_base_url
    "http://res.cloudinary.com/eli/image/upload"
  end

  def image_url
    "#{Video.cl_base_url}/#{image_id}"
  end


end
