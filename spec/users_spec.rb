require 'rails_helper'

RSpec.feature "ユーザー管理機能",type: :system do
  background do
    @user = User.create(name:"テストユーザー",email:"test@mail.com",admin: false,password:"password",password_confirmation:"password")
    visit new_session_path
    fill_in "Email",with: "test@mail.com"
    fill_in "Password",with: "password"
    click_button "Log in"
  end
  scenario "ユーザー作成テスト" do
    visit new_user_path
    fill_in "Name",with: "作成テスト"
    fill_in "Email",with: "create_test@mail.com"
    fill_in "Password",with: "password"
    fill_in "Password confirmation",with: "password"
    click_button "登録する"
    expect(page).to have_content "作成テスト"
  end

  scenario "ユーザー 一覧テスト" do
    User.create(name:"ユーザー 一覧テスト",email:"indextest@mail.com",admin: false,password:"password",password_confirmation:"password")
    visit users_path
    expect(page).to have_content "ユーザー 一覧テスト"
    expect(page).to have_content "テストユーザー"
  end

  scenario "ユーザー詳細テスト" do
    visit user_path(@user.id)
    expect(page).to have_content "テストユーザー"
  end

  scenario "ユーザー編集テスト" do
    visit edit_user_path(@user.id)
    fill_in "Name",with: "ユーザー編集テスト"
    fill_in "Password",with: "password"
    fill_in "Password confirmation",with: "password"
    click_button "更新する"
    expect(page).to have_content "ユーザー編集テスト"
  end

  scenario "ユーザー削除テスト" do
    visit edit_user_path(@user.id)
    click_link "ユーザー削除"
    expect(page.driver.browser.switch_to.alert.text).to have_content "本当に削除しますか？"
    page.driver.browser.switch_to.alert.accept
    expect(page).not_to have_content "テスト"
  end

  scenario "ログイン&ログアウト" do
    click_link "ログアウト"
    click_link "ログイン"
    fill_in "Email",with: "test@mail.com"
    fill_in "Password",with: "password"
    click_button "Log in"
    expect(page).to have_content "ユーザープロフィール"
    expect(page).to have_content "テストユーザー"
  end

  scenario "ログインしないと質問投稿できないテスト" do
    click_link "ログアウト"
    visit new_question_path
    expect(page).to have_content "ログインが必要です"
  end
end