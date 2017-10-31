class AccountsController < ApplicationController
  def show
  end

  def edit
    @account = current_user.account
  end

  def update
    @account = current_user.account
    print account_params
    if @account.update(account_params)
      flash[:success] = "Profile Successfully Updated"
      redirect_to user_path(@account.user)
    else
      render 'edit'
    end
  end


  def submitted_params
    params.permit(:paypal_email)
  end

  def account_params
    if params[:image_id].present?
      preloaded = Cloudinary::PreloadedFile.new(params[:image_id])
      raise "Invalid upload signature" if !preloaded.valid?
      submitted_params.merge(image: preloaded.identifier)
    else
      submitted_params
    end
  end


end
