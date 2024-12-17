class Image < ApplicationRecord
 
  belongs_to :user
  belongs_to :post
  mount_uploader :image_url, ImageUploader
end
