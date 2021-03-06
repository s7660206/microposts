class UsersController < ApplicationController
 before_action :set_params, only: [:show, :edit, :update]
 before_action :correct_user, only: [:edit, :update]
  
  def show
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Updated Profile"
      redirect_to @user
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  
  def followings
    @title = 'followings'
    @user = User.find(params[:id])
    @users = @user.following_users
    render 'show_follow'
  end

  def followers
    @title = 'followers'
    @user = User.find(params[:id])
    @users = @user.follower_users
    render 'show_follow'
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :location, :password,
                                 :password_confirmation)
  end
  
  def set_params
    @user = User.find(params[:id])
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
  end
end

