15.times do |i|
  Answer.seed do |s|
    s.id = i+1
    s.content = "回答#{i+1}"
    s.question_id = i+1
    s.answerer_id = i+1
  end
end