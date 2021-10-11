class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category_id
  belongs_to :sales_status_id
  belongs_to :shipping_fee_status_id
  belongs_to :prefecture_id
  belongs_to :scheduled_delivery_id

  belongs_to :user
  has_one_attached :image

end
