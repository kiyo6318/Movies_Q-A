class Like < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates_uniqueness_of :question_id, scope: :user_id
end
