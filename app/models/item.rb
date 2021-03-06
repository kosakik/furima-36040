class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  belongs_to :user
  has_one    :order

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
    with_options format: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters' } do
      validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 , message: "is out of setting range"} 
    end
  end

  with_options numericality: { other_than: 0 , message: "can't be blank"} do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

end
