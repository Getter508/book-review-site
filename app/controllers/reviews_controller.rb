class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @review = Review.new(review_params)
    @review.book_id = @book.id
    @review.user_id = current_user.id

    if @review.save
      redirect_to book_path(@book), notice: 'Your review was posted successfully'
    else
      @reviews = @book.reviews.order(created_at: :desc)
      @vote = Vote.new
      render "books/show"
    end
  end

  def edit
    @review = Review.find(params[:id])
    @book = Book.find(params[:book_id])
  end

  def update
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])
    @review.assign_attributes(review_params)

    if @review.save
      redirect_to book_path(@book), notice: 'Your review was successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    book = Book.find(params[:book_id])
    review = Review.find(params[:id])
    review.destroy
    redirect_to book_path(book), notice: 'Your review was successfully deleted'
  end

  protected

  def review_params
    params.require(:review).permit(:rating, :title, :body)
  end
end
