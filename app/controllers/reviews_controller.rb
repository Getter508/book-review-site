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
    @review.update_attributes(review_params)

    if @review.save
      redirect_to book_path(@book), notice: 'Your review was successfully updated'
    else
      render 'edit'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :title, :body)
  end
end
