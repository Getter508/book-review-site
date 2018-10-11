class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.find(params[:review_id])
    @book = @review.book

    if Vote.update_or_destroy(current_user, @review, vote_params[:upvote])
      redirect_to book_path(@book)
    else
      @reviews = @book.reviews.order(created_at: :desc)
      @vote = Vote.new
      render "books/show"
    end
  end

  protected

  def vote_params
    params.require(:vote).permit(:upvote)
  end
end
