class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def search_book
    @book = Book.new
    @books = Book.search(params[:keyword])
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    current_user.view_counts.create(book_id: @book.id)
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new
      if params[:latest]
      @books = Book.latest
      elsif params[:old]
        @books = Book.old
      elsif params[:rate_count]
        @books = Book.rate_count
      else
        @books = Book.all.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
      end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :rate, :category)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    user_id = book.user_id
    unless user_id == current_user.id
      redirect_to books_path
    end
  end

end
