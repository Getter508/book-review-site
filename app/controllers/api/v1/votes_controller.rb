class Api::V1::VotesController < ApplicationController
  def create
    review = Review.find(vote_params[:review_id])
    previous_vote = Vote.find_by(review: review, user: current_user)

    if Vote.update_or_destroy(current_user, review, vote_params[:upvote])
      render json: {
        updated_net_votes: review.net_upvotes,
        review_id: review.id,
        status: :created
      }
    else
      render json: :nothing, status: :not_found
    end
  end

  protected

  def vote_params
    params.require(:vote).permit(:upvote, :review_id)
  end
end
