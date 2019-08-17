15.times do |i|
  Question.seed do |s|
    s.id = i+1
    s.title = "タイトル#{i+1}"
    s.details = "詳細#{i+1}"
    s.questioner_id = User.find(i+1).id
  end
  Question.find(i+1).labels = [Label.find(i+1)]
end