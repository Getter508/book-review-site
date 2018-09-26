class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.order(created_at: :desc)
    @review = Review.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      redirect_to @book, notice: 'Book was submitted successfully'
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update_attributes(book_params)

    if @book.save
      redirect_to @book, notice: 'This book was successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice: 'This book was successfully deleted'
  end

  private

  def book_params
    params.require(:book).permit(
      :title,
      :author,
      :year,
      :genre,
      :synopsis,
      :image_url
    )
  end
end
