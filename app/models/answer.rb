class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user,foreign_key: "answerer_id",optional: true
  counter_culture :user,column_name: -> (model) { model.best_answer == true ? "best_answers_count":nil}
  validates :content,presence: true,length: {maximum:750}
end
