require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do

    context '新規登録できる場合' do
      it "全ての項目が正しく入力されれば登録できる" do
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上且つ半角英数字混合であれば登録できる' do
        @user.password = '1234abcd'
        @user.password_confirmation = '1234abcd'
        expect(@user).to be_valid
      end

      it 'last_nameが全角（漢字・ひらがな・カタカナ）であれば入力できる' do
        @user.last_name = '山田やまだヤマダ'
        expect(@user).to be_valid
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ）であれば入力できる' do
        @user.last_name = '陸太郎りくたろうリクタロウ'
        expect(@user).to be_valid
      end

      it 'last_name_kanaが全角（カタカナ）であれば入力できる' do
        @user.last_name_kana = 'ヤマダ'
        expect(@user).to be_valid
      end

      it 'first_name_kanaが全角（カタカナ）であれば入力できる' do
        @user.last_name_kana = 'リクタロウ'
        expect(@user).to be_valid
      end

    end

    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "重複したemailが存在する場合、登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it "emailに@が含まれていない場合、登録できない" do
        @user.email = 'testgmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "passwordが6文字未満では登録できない" do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it "passwordが半角英数字混合でなければ登録できない" do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'last_nameが半角文字では登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
      end

      it 'first_nameが半角文字では登録できない' do
        @user.first_name = 'rikutarou'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'last_name_kanaがひらがなでは登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end

      it 'first_name_kanaがひらがなでは登録できない' do
        @user.first_name_kana = 'りくたろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end

      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end

    end
  end

end
