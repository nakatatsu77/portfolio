class Image < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :post

  # mount_uploader を利用して image_url を管理
  mount_uploader :image_url, ImageUploader

  # 外部URLを処理するリモート機能を有効化
  attr_accessor :remote_image_url

  before_validation :process_remote_image_url, if: -> { remote_image_url.present? }

  private

  # リモートURLをファイルとして保存
  def process_remote_image_url
    begin
      downloaded_file = download_remote_image(remote_image_url)
      self.image_url = downloaded_file
    rescue StandardError => e
      Rails.logger.error "Error fetching remote image: #{e.message}"
      errors.add(:remote_image_url, "画像を取得できませんでした")
      throw :abort
    end
  end

  # 外部画像を一時ファイルとしてダウンロード
  def download_remote_image(url)
    require "open-uri"
    file = URI.open(url)
    file.define_singleton_method(:original_filename) do
      File.basename(URI.parse(url).path)
    end
    file
  end
end
