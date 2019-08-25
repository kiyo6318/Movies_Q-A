require 'rails_helper'

RSpec.feature "いいね機能テスト",type: :system do
  background do
    @user = User.create(name:"テストユーザー",email:"test@mail.com",admin: false,password:"password",password_confirmation:"password")
    @question = Question.create(title:"テストタイトル",details:"テスト詳細",status:0,questioner_id:@user.id)
    visit new_session_path
    fill_in "メールアドレス",with: "test@mail.com"
    fill_in "パスワード",with: "password"
    click_button "ログイン"
  end

  scenario "いいね付与テスト" do
    visit question_path(@question.id)
    click_button "like_button"
    expect(page).to have_content "いいね 1"
  end

  scenario "いいね解除テスト" do
    visit question_path(@question.id)
    click_button "like_button"
    click_button "like_button_already"
    expect(page).to have_content "いいね 0"
  end
end