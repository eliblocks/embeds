class UsersController < ApplicationController
  def library

  end

  def index
    @users = User.all
  end
end
