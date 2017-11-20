class Admin::DashboardController < Admin::AdminController
  def index
    @users_count = User.count
    @last_signup = User.last
    @videos_count = Video.count
    @last_upload = Video.last
  end

end
