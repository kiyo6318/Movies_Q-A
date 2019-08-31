require 'rails_helper'

RSpec.feature "つながり機能テスト",type: :system do
  background do
    @user = User.create(name:"ユーザー",email:"user@mail.com",password:"password",password_confirmation:"password")
    @other_user = User.create(name:"他のユーザー",email:"otheruser@mail.com",password:"password",password_confirmation:"password")
    visit new_session_path
    fill_in "メールアドレス",with: "user@mail.com"
    fill_in "パスワード",with: "password"
    click_button "ログイン"
  end
  scenario "フォローテスト" do
    visit user_path(@other_user)
    click_on "＋フォロー"
    visit relations_user_path(@user)
    expect(page).to have_content "他のユーザー"
  end