require 'rails_helper'

RSpec.feature "回答管理機能",type: :system do
  background do
    @test_questioner = User.create(name:"テストユーザー",email:"test@mail.com",password:"password",password_confirmation:"password")
    @test_answerer = User.create(name:"テストユーザー2",email:"test2@mail.com",password:"password",password_confirmation:"password")
    @test_question = Question.create(title:"テストタイトル",details:"テスト詳細",status:0,questioner_id:@test_questioner.id)
    @test_answer = Answer.create(content:"テスト回答",question_id:@test_question.id,answerer_id:@test_answerer.id)
  end

  scenario "回答投稿テスト" do
    visit question_path(@test_question.id)
    fill_in "answer_content",with: "回答テスト投稿"
    click_button "投稿する"
    expect(page).to have_content "回答テスト投稿"
  end

  scenario "回答一覧テスト" do
    visit question_path(@test_question.id)
    expect(page).to have_content "テスト回答"
  end

  scenario "回答削除テスト" do
    visit new_session_path
    fill_in "メールアドレス",with: "test2@mail.com"
    fill_in "パスワード",with: "password"
    click_button "ログイン"
    visit question_path(@test_question.id)
    click_link "回答を削除"
    expect(page.driver.browser.switch_to.alert.text).to have_content "本当に削除しますか？"
    page.driver.browser.switch_to.alert.accept
    expect(page).not_to have_content "テスト回答"
  end

  scenario "ベストアンサーテスト" do
    visit new_session_path
    fill_in "メールアドレス",with: "test@mail.com"
    fill_in "パスワード",with: "password"
    click_button "ログイン"
    visit question_path(@test_question.id)
    click_link "ベストアンサーに選ぶ"
    expect(page.driver.browser.switch_to.alert.text).to have_content "この回答をベストアンサーに決定しますか？"
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "ベストアンサー"
  end
end