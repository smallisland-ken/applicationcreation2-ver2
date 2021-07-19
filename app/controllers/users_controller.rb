class UsersController < ApplicationController

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @book = Book.new
    # 空のインスタンス変数なのでnewは可能。
    @users = User.all
    @user = User.find(current_user.id)
  end

  def edit
   @user = User.find(params[:id])
   if @user == current_user
     render "edit"
   else
    redirect_to edit_user(@user)
  end
  end

  def create
    @book = @user.books
    @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to user_path(current_user.id)
  end

  def update
  @user = User.find(params[:id])
  if @user.update(list_params)
  flash[:notice] = "You have updated user successfully."
  redirect_to user_path(current_user.id)
  else
    render :edit
  end
  end

  private
  
  def list_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
