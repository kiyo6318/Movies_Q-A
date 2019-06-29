class QuestionsController < ApplicationController
  before_action :set_question,only: %i(show edit update destroy)
  before_action :authenticate_user,only: %i(new create edit update destroy)
  before_action :ensure_correct_user,only: %i(edit update destroy)
  def index
    # @questions = Question.all
    @q = Question.ransack(params[:q])
    @q.sorts = 'created_at desc' if @q.sorts.empty?
    @statuses = Question.statuses
    @questions = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.questioner_id = current_user.id
    if @question.save
      redirect_to question_path(@question.id),notice:"質問を投稿しました！"
    else
      render "new"
    end
  end

  def show
    @answers = @question.answers
    @answer = @question.answers.build
  end

  def edit
  end

  def update
    if @question.update(question_params)
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
    params.require(:question).permit(:title,:details,:status,label_ids:[])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def ensure_correct_user
    if @question.user != current_user
      redirect_back(fallback_location: questions_path,notice:"権限がありません")
    end
  end
end
