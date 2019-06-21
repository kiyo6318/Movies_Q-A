require 'rails_helper'

RSpec.feature "ユーザー管理機能",type: :system do
  background do
    @user = User.create(name:"テスト",email:"test@mail.com",admin: false,password:"password",password_confirmation:"password")
  end
  scenario "ユーザー作成テスト" do
    visit new_user_path
    fill_in "Name",with: "作成テスト"
    fill_in "Email",with: "create_test@mail.com"
    fill_in "Password",with: "password"
    fill_in "Password confirmation",with: "password"
    click_button "Create User"
    expect(page).to have_content "作成テスト"
  end

  scenario "ユーザー 一覧テスト" do
    visit users_path
    expect(page).to have_content "テスト"
  end

  scenario "ユーザー詳細テスト" do
    visit user_path(@user.id)
    expect(page).to have_content "テスト"
  end

  scenario "ユーザー編集テスト" do
    visit edit_user_path(@user.id)
    fill_in "Name",with: "編集テスト"
    fill_in "Password",with: "password"
    fill_in "Password confirmation",with: "password"
    click_button "Update User"
    expect(page).to have_content "編集テスト"
  end

  scenario "ユーザー削除テスト" do
    visit edit_user_path(@user.id)
    click_link "ユーザー削除"
    expect(page.driver.browser.switch_to.alert.text).to have_content "本当に削除しますか？"
    page.driver.browser.switch_to.alert.accept
    expect(page).not_to have_content "テスト"
  end
end