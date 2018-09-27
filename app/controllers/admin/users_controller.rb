class Admin::UsersController < ApplicationController
  before_action :authorize_user

  def index
    @users = User.order(last_name: :asc)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path, notice: 'User was deleted successfully'
  end

  protected

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end

# def destroy
#   user = User.find(params[:id])
#
#   if !user.admin
#     user.destroy
#     notice: 'User was deleted successfully'
#   else
#     alert: 'Cannot delete admins'
#   end
#
#   redirect_to admin_users_path
# end
