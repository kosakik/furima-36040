class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category_id
  belongs_to :sales_status_id
  belongs_to :shipping_fee_status_id
  belongs_to :prefecture_id
  belongs_to :scheduled_delivery_id

  belongs_to :user
  
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :name
    validates :explain
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  end

  with_options numericality: { other_than: 0 , message: "can't be blank"} do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

end
