require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "nameが空ならバリデーションが通らない" do
      user = User.new(name:"",email:"test@mail.com",password:"password",password_confirmation:"password")
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to be_include("名前を入力してください")
    end

    it "emailが空ならバリデーションが通らない" do
      user = User.new(name:"test",email:"",password:"password",password_confirmation:"password")
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to be_include("メールアドレスを入力してください")
    end

    it "emailが正規表現のパターンにマッチしないとバリデーションが通らない" do
      user = User.new(name:"test",email:"testtesttest",password:"password",password_confirmation:"password")
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to be_include("メールアドレスは不正な値です")
    end

    it "入力したemailが既に存在しているとバリデーションが通らない" do
      user1 = User.create(name:"test1",email:"test@mail.com",password:"password",password_confirmation:"password")
      user2 = User.new(name:"test2",email:"test@mail.com",password:"password",password_confirmation:"password")
      expect(user2).not_to be_valid
      expect(user2.errors.full_messages).to be_include("メールアドレスはすでに存在します")
    end

    it "パスワードが空ならバリデーションが通らない" do
      user = User.new(name:"test",email:"test@mail.com",password:"",password_confirmation:"")
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to be_include("パスワードを入力してください")
    end

    it "パスワードが6文字未満ならバリデーションが通らない" do
      user = User.new(name:"test",email:"test@mail.com",password:"aaaaa",password_confirmation:"aaaaa")
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to be_include("パスワードは6文字以上で入力してください")
    end

    it "確認用パスワードとパスワードの入力が一致しないとバリデーションが通らない" do
      user = User.new(name:"test",email:"test@mail.com",password:"aaaaaaaa",password_confirmation:"bbbbbbbb")
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to be_include("確認用パスワードとパスワードの入力が一致しません")
    end
  end
end