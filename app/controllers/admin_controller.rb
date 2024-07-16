class AdminController < ActionController::Base
  before_action :authenticate_user!
  # before_action :check_user_role
  include Pagy::Backend
  layout "admin"

  # private

  #  def check_user_role
  #   if current_user.admin?
  #     redirect_to admin_dashboard_path unless request.path == admin_dashboard_path
  #   elsif current_user.staff?
  #     redirect_to admin_bookshop_path unless request.path == admin_bookshop_path
  #    else
  #     redirect_to root_path, alert: 'You do not have the necessary permissions.'
  #   end
  # end
end