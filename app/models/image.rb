class Image < ApplicationRecord
  validates :image_url, presence: true
  belongs_to :user
  belongs_to :post
  mount_uploader :image_url, ImageUploader
end
