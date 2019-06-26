class Question < ApplicationRecord
  belongs_to :user,foreign_key: "questioner_id"
  has_many :answers,dependent: :destroy
  validates :title,presence: true
  validates :details,presence: true
  enum status:{unsolved:0,resolved:1}
end
