class QuestionsController < ApplicationController
  before_action :set_question,only: %i(show edit update destroy)
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to question_path(@question.id),notice:"質問を投稿しました！"
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @question.update(question_path)
      redirect_to question_path(@question.id),notice:"質問を更新しました！"
    else
      render "edit"
    end
  end

  def destroy
    @question.destroy
    if @question.destroy
      redirect_to questions_path,notice:"質問を削除しました！"
    end
  end

  private
  def question_params
    params.require(:question).permit(:title,:details,:status)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
