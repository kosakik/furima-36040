require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do

    context '商品出品できる場合' do
      it "全ての項目が正しく入力されれば出品できる" do
        expect(@item).to be_valid
      end

      it "category_idは、0以外を選択すれば出品できる" do
        @item.category_id = 1
        expect(@item).to be_valid
      end

      it "sales_status_idは、0以外を選択すれば出品できる" do
        @item.sales_status_id = 1
        expect(@item).to be_valid
      end

      it "shipping_fee_status_idは、0以外を選択すれば出品できる" do
        @item.shipping_fee_status_id = 1
        expect(@item).to be_valid
      end

      it "prefecture_idは、0以外を選択すれば出品できる" do
        @item.prefecture_id = 1
        expect(@item).to be_valid
      end

      it "scheduled_delivery_idは、0以外を選択すれば出品できる" do
        @item.scheduled_delivery_id = 1
        expect(@item).to be_valid
      end

      it "pciceは、300〜9999999の範囲内であれば出品できる" do
        @item.price = 300
        expect(@item).to be_valid
      end
    end

    context '商品出品できない場合' do
      it "userが紐付いていなければ出品できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end

      it "imageが空では出品できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it "nameが空では出品できない" do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it "explainが空では出品できない" do
        @item.explain = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explain can't be blank")
      end

      it "category_idが0では出品できない" do
        @item.category_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it "sales_status_idが0では出品できない" do
        @item.sales_status_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status can't be blank")
      end

      it "shipping_fee_status_idが0では出品できない" do
        @item.shipping_fee_status_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
      end

      it "prefecture_idが0では出品できない" do
        @item.prefecture_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it "scheduled_delivery_idが0では出品できない" do
        @item.scheduled_delivery_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
      end

      it "priceが空では出品できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it "priceに半角数字以外が含まれている場合は出品できない" do
        @item.price = 'test'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end

      it "priceは、300未満では出品できない" do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end

      it "priceは、9999999より大きい値では出品できない" do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end

    end

  end
end
