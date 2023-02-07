class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def daily_posts
      user = User.find(params[:user_id])
      @books = user.books.where(created_at: params[:created_at].to_date.all_day)
      render :daily_posts_form
  end
  
    
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @today_book =  @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    @book = Book.new
    @book_detail = Book.find(params[:id])
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book_detail.id)
      current_user.view_counts.create(book_id: @book_detail.id)
    end
    @tag_list = Tag.all
  end

  def index
    @users = User.all
    @book = Book.new
    @tag_list = Tag.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

    private

    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end

    def ensure_correct_user
      user = User.find(params[:id])
      unless user == current_user
        redirect_to user_path(current_user)
      end
    end
end
