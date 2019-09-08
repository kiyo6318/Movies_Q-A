class AnswerMailer < ApplicationMailer
  def answer_mail(question)
    @question = question

    mail to: @question.user.email,subject: "あなたの質問に回答がありました"
  end
end
