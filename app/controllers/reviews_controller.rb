class ReviewsController < ApplicationController
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

  private

  def review_params
    params.require(:review).permit(:rating, :title, :body)
  end
end
