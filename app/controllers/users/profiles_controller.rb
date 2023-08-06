class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update
    if current_user.update(profile_params)
      redirect_to user_profile_path, notice: "Profile updated successfully."
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:full_name, :email, :phone_number, :password, :password_confirmation, :current_password)
  end
end
