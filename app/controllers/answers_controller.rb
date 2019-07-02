class AnswersController < ApplicationController
  before_action :set_question
  before_action :set_answer,only: %i(update destroy)

  def create
    @answer = @question.answers.build(answer_params)
    @answer.answerer_id = current_user.id if current_user
    respond_to do |format|
      if @answer.save
        format.js { render :index }
      else
        format.html { redirect_to question_path(@question),notice:"投稿できませんでした" }
      end
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@question)
  end

  def update
    if @answer.best_answer == false
      @answer.update(best_answer: true)
    end
    redirect_to question_path(@question)
  end

  private
  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:content,:best_answer)
  end
end
