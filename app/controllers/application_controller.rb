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
      params[:q]['title_or_details_or_labels_genre_cont_any'] = params[:q]['title_or_details_or_labels_genre_cont_any'].to_s.split(/[\p{blank}\s]+/)
      @search = Question.ransack(params[:q])
      @search_questions = @search.result.includes(:labels).page(params[:page]).per(10)
    else
      @search = Question.ransack(params[:q])
      @search_questions = @search.result.includes(:labels).page(params[:page]).per(10)
    end
  end
end
