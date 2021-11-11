class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # skip_before_action :verify_authenticity_token, only: :facebook

  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in @user
      redirect_to root_path
      set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    else
      flash[:alert] = "We can't create an account with your Github. Please sign up manually"
      redirect_to new_user_registration_path
    end
  end

  def twitter
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in @user
      redirect_to root_path
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
    else
      flash[:alert] = "We can't create an account with your Twitter. Please sign up manually"
      redirect_to new_user_registration_path
    end
  end

  def failure
    redirect_to root_path
  end
end
