require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe "バリデーション" do
    it "contentが空ならバリデーションが通らない" do
      question = Question.new(title:"テストタイトル",details:"テスト詳細")
      answer = Answer.new(content:"",question_id:question.id)
      expect(answer).not_to be_valid
      expect(answer.errors.full_messages).to be_include("回答内容を入力してください")
    end

    it "contentが751文字以上ならバリデーションが通らない" do
      question = Question.new(title:"テストタイトル",details:"テスト詳細")
      answer = Answer.new(content:"a"*751,question_id:question.id)
      expect(answer).not_to be_valid
      expect(answer.errors.full_messages).to be_include("回答内容は750文字以内で入力してください")
    end
  end
end
