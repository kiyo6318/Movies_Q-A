class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)
  before_action :authenticate_user, only: %i(edit update destroy)
  before_action :ensure_correct_user, only: %i(edit update destroy)
  def index
    @q = User.ransack(params[:q])
    @users = @q.result.includes(:answers).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id),notice:"ユーザー登録完了しました!"
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id),notice: "ユーザー情報を更新しました!"
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    if @user.destroy
      redirect_to users_path,notice: "ユーザーを削除しました!"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:admin,:password,:password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    if @user != current_user
      redirect_back(fallback_location: questions_path,notice:"権限がありません")
    end
  end
end
