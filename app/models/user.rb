class User < ApplicationRecord
  has_many :questions,foreign_key: "questioner_id",dependent: :destroy
  has_many :answers,foreign_key: "answerer_id",dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question

  before_validation { email.downcase! }
  has_secure_password
  validates :name,presence: true,length: {maximum: 30 }
  validates :email,presence: true,length: {maximum: 255 },uniqueness: true,
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password,presence: true,length:{minimum: 6}

  def already_liked?(question)
    self.likes.exists?(question_id: question.id)
  end
end