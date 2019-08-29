class UsersController < ApplicationController
  before_action :set_user, only: %i(edit update destroy)
  before_action :authenticate_user, only: %i(edit update destroy)
  before_action :ensure_correct_user, only: %i(edit update destroy)
  before_action :admin_cannot_delete, only: %i(destroy)
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(10)
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
    @user = User.includes(questions: :labels).find(params[:id])
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

  def relations
    @user = User.includes(:following,:followers).find(params[:id])
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

  def admin_cannot_delete
    if @user.admin == true
      redirect_to user_path(@user.id),notice:"管理者は削除できません"
    end
  end
end
