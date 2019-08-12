require 'rails_helper'

RSpec.feature "質問管理機能",type: :system do
  background do
    @test_questioner = User.create(name:"テストユーザー",email:"test@mail.com",password:"password",password_confirmation:"password")
    @test_question = Question.create(title:"テストタイトル",details:"テスト詳細",status:0,questioner_id:@test_questioner.id)
    visit new_session_path
    fill_in "メールアドレス",with: "test@mail.com"
    fill_in "パスワード",with: "password"
    click_button "ログイン"
  end
  scenario "質問投稿テスト" do
    visit new_question_path
    fill_in "question_title",with: "投稿テストタイトル"
    fill_in "question_details",with: "投稿テスト詳細"
    click_button "投稿する"
    expect(page).to have_content "投稿テストタイトル"
  end

  scenario "質問一覧テスト" do
    Question.create(title:"テストタイトル2",details:"テスト詳細2",status:0,questioner_id:@test_questioner.id)
    visit questions_path
    expect(page).to have_content "テストタイトル"
    expect(page).to have_content "テストタイトル2"
  end

  scenario "質問詳細テスト" do
    visit questions_path
    click_link "テストタイトル"
    expect(page).to have_content "テストユーザー"
    expect(page).to have_content "テストタイトル"
    expect(page).to have_content "テスト詳細"
    expect(page).to have_content "未解決"
  end

  scenario "質問編集テスト" do
    visit questions_path
    click_link "テストタイトル"
    click_link "質問編集"
    fill_in "question_details",with: "編集テスト詳細"
    click_button "更新する"
    expect(page).to have_content "編集テスト詳細"
  end

  scenario "質問削除テスト" do
    visit questions_path
    click_link "テストタイトル"
    click_link "質問編集"
    click_link "質問削除"
    expect(page.driver.browser.switch_to.alert.text).to have_content "本当に削除しますか？"
    page.driver.browser.switch_to.alert.accept
    expect(page).not_to have_content "テストタイトル"
  end

  scenario "ページネーション(次へ)" do
    50.times do |i|
      Question.create(title:"次へタイトル#{i+1}",details:"次へ詳細#{i+1}",status:0,questioner_id:@test_questioner.id)
    end
    visit questions_path
    click_link "次へ ›"
    binding.pry
    expect(page).to have_content "次へタイトル40"
  end

  scenario "ページネーション(最後へ)" do
    50.times do |i|
      Question.create(title:"最後へタイトル#{i+1}",details:"最後へ詳細#{i+1}",status:0,questioner_id:@test_questioner.id)
    end
    visit questions_path
    click_link "最後へ »"
    expect(page).to have_content "テストタイトル"
  end

  scenario "ページネーション(前へ)" do
    50.times do |i|
      Question.create(title:"前へタイトル#{i+1}",details:"前へ詳細#{i+1}",status:0,questioner_id:@test_questioner.id)
    end
    visit questions_path
    click_link "最後へ »"
    click_link "‹ 前へ"
    expect(page).to have_content "前へタイトル1"
  end

  scenario "ページネーション(最初へ)" do
    50.times do |i|
      Question.create(title:"最初へタイトル#{i+1}",details:"最初へ詳細#{i+1}",status:0,questioner_id:@test_questioner.id)
    end
    visit questions_path
    click_link "最後へ »"
    click_link "« 最初へ"
    expect(page).to have_content "最初へタイトル50"
  end
end