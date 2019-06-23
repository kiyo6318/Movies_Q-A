class Question < ApplicationRecord
  belongs_to :user,foreign_key: "questioner_id"
  validates :title,presence: true
  validates :details,presence: true
end
