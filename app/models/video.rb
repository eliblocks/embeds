class Video < ApplicationRecord
  include ClipUploader[:clip]
  belongs_to :user
end
