class User < ApplicationRecord
  has_many :questions,foreign_key: "questioner_id",dependent: :destroy
  has_many :answers,foreign_key: "answerer_id",dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question
  has_many :active_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :passive_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_validation { email.downcase! }
  has_secure_password
  validates :name,presence: true,length: {maximum: 30 }
  validates :email,presence: true,length: {maximum: 255 },uniqueness: true,
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password,presence: true,length:{minimum: 6}

  def already_liked?(question)
    self.likes.exists?(question_id: question.id)
  end

  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
end