class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books.all
    @book = Book.new
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @book = Book.new
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id),
      notice: "You have updated user successfully."
    else
      render "edit"
    end
  end
  
  def followed
    @user = User.find_by(id: params[:id])
    @users = @user.followed
    render 'show_follow'
  end

  def followers
    @user  = User.find_by(id: params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
