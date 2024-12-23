class CreateImages < ActiveRecord::Migration[7.2]
  def change
    create_table :images do |t|
      t.text :image_url, null: true # 画像URL
      t.boolean :is_generated_by_ai, null: false, default: false # AI生成画像かどうか
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
