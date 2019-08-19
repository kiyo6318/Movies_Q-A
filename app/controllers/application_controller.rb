class ApplicationController < ActionController::Base
  before_action :set_search
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user
    if current_user == nil
      redirect_to new_session_path,notice:"ログインが必要です"
    end
  end

  def set_search
    if params[:q] != nil
      @search = Question.ransack(params[:q])
      @search_questions = @search.result.distinct.includes(:labels).page(params[:page]).per(10)
    else
      @search = Question.ransack(params[:q])
      @search_questions = @search.result.includes(:labels).page(params[:page]).per(10)
    end
  end
end