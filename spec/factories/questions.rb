FactoryBot.define do
  factory :question do
    title { "MyString" }
    details { "MyText" }
    status { 1 }
    questioner { nil }
  end
end
