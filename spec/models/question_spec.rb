require 'rails_helper'

RSpec.describe Question, type: :model do

  describe "バリデーション" do
    it "titleが空ならバリデーションが通らない" do
      question = Question.new(title:"",details:"テスト")
      expect(question).not_to be_valid
      expect(question.errors.full_messages).to be_include("タイトルを入力してください")
    end

    it "detailsが空ならバリデーションが通らない" do
      question = Question.new(title:"テスト",details:"")
      expect(question).not_to be_valid
      expect(question.errors.full_messages).to be_include("詳細を入力してください")
    end

    it "titleの文字数が46文字以上だとバリデーションが通らない" do
      question = Question.new(title:"a"*46,details:"テスト")
      expect(question).not_to be_valid
      expect(question.errors.full_messages).to be_include("タイトルは45文字以内で入力してください")
    end

    it "detailsの文字数が751文字以上だとバリデーションが通らない" do
      question = Question.new(title:"テスト",details:"a"*751)
      expect(question).not_to be_valid
      expect(question.errors.full_messages).to be_include("詳細は750文字以内で入力してください")
    end
  end
end
