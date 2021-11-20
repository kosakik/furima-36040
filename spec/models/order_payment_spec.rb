require 'rails_helper'

RSpec.describe OrderPayment, type: :model do
  before do
    @order_payment = FactoryBot.build(:order_payment)
  end

  describe '商品購入機能' do

    context '商品の配送先情報が保存できるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_payment).to be_valid
      end
      it 'user_idが空でなければ保存できる' do
        @order_payment.user_id = 1
        expect(@order_payment).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @order_payment.item_id = 1
        expect(@order_payment).to be_valid
      end
      it 'postal_coadは、「3桁ハイフン4桁」の半角文字列であれば保存できる' do
        @order_payment.postal_code = '123-4567'
        expect(@order_payment).to be_valid
      end
      it 'prefecture_idは、0以外を選択すれば保存できる' do
        @order_payment.prefecture_id = 1
        expect(@order_payment).to be_valid
      end
      it 'cityは、空でなければ保存できる' do
        @order_payment.city = '横浜市緑区'
        expect(@order_payment).to be_valid
      end
      it 'addressesは、空でなければ保存できる' do
        @order_payment.addresses = '青山123'
        expect(@order_payment).to be_valid
      end
      it 'buildingは、空でも保存できる' do
        @order_payment.building = nil
        expect(@order_payment).to be_valid
      end
      it 'phone_numberは、10桁以上11桁以内の半角数値のみ保存できる' do
        @order_payment.phone_number = '09012345678'
        expect(@order_payment).to be_valid
      end
    end

    context '商品の配送先情報が保存ができないとき' do
      it 'user_idは、空だと保存できない' do
        @order_payment.user_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idは、空だと保存できない' do
        @order_payment.item_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Item can't be blank")
      end
      it 'postal_codeは、空だと保存できない' do
        @order_payment.postal_code = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Postal code can't be blank", 'Postal code is invalid. Include hyphen(-)')
      end
      it 'postal_codeは、ハイフンがないと保存できない' do
        @order_payment.postal_code = '1234567'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idは、0だと保存できない' do
        @order_payment.prefecture_id = '0'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityは、空だと保存できない' do
        @order_payment.city = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("City can't be blank")
      end
      it 'addressesは、空だと保存できない' do
        @order_payment.addresses = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Addresses can't be blank")
      end
      it 'phone_numberは、空だと保存できない' do
        @order_payment.phone_number = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberは、ハイフンがあると保存できない' do
        @order_payment.phone_number = '090-1234-5678'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberは、12桁以上あると保存できない' do
        @order_payment.phone_number = '090123456789'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Phone number is invalid')
      end
      it 'takenは、空だと保存できない' do
        @order_payment.token = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end