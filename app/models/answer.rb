class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user,foreign_key: "answerer_id",optional: true
  validates :content,presence: true
end
