class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @books = Book.all
    if params[:search]
      @header = "Search Results"
      books = Book.search(params[:search])
      authors = Author.search(params[:search]).includes(:books)
      books_from_authors = authors.collect { |author| author.books }.flatten
      @books = (books + books_from_authors).uniq.sort_by(&:title)
    else
      @header = "All Books"
      @books = Book.order(title: :asc)
    end
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.order(created_at: :desc)
    @review = Review.new
    @vote = Vote.new
  end

  def new
    @book = Book.new
    @book.build_author
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    author = Author.find_or_create_by(book_params[:author_attributes])
    @book.author_id = author.id

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
    @book.assign_attributes(book_params)
    author = Author.find_or_create_by(book_params[:author_attributes])
    @book.author_id = author.id

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

  protected

  def book_params
    params.require(:book).permit(
      :title, :year, :genre, :synopsis, :image, :remove_image,
      author_attributes: [:first_name, :middle_name, :last_name, :suffix]
    )
  end
end
