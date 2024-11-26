class Image < ApplicationRecord
  mount_uploader :image_url, ImageUploader

  belongs_to :user
  belongs_to :post
end
