class Admin::AdminController < ApplicationController
  before_action :authorize_admin

  def authorize_admin
    redirect_to root_url unless current_user.admin
  end
end
