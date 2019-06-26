FactoryBot.define do
  factory :answer do
    content { "MyText" }
    best_answer { false }
    answerer_id { 1 }
    question { nil }
  end
end
