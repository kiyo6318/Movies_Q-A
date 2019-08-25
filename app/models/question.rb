class Question < ApplicationRecord
  belongs_to :user,foreign_key: "questioner_id"
  has_many :answers,dependent: :destroy
  has_many :question_labels,dependent: :destroy
  has_many :labels,through: :question_labels,source: :label
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  ransack_alias :search, :title_or_details_or_labels_genre
  validates :title,presence: true,length: {maximum: 45}
  validates :details,presence: true,length: {maximum: 750}
  enum status:{unsolved:0,resolved:1}
  default_scope -> { order(created_at: :desc) }
end