class Label < ApplicationRecord
  has_many :question_labels,dependent: :destroy
  has_many :questions,through: :question_labels,source: :question
end
