class Post < ApplicationRecord
  validates :body, presence: true, length: { maximum: 65_535 }

  belongs_to :user
  has_one :image, dependent: :destroy
  # app/views/posts/new.html.erbでネストされたフォームを動作させる
  accepts_nested_attributes_for :image, allow_destroy: true
end
