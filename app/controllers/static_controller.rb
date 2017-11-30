class StaticController < ApplicationController
  def about
  end

  def contact
  end

  def privacy
  end

  def terms
  end

  def stats
  end

  def welcome
    if user_signed_in?
      redirect_to root_path
    end
  end
end
