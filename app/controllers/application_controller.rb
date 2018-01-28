class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

  protected

  def configure_devise_permitted_parameters
    registration_params = [:email, :password, :password_confirmation, :first_name, :last_name, :image, :phone_number, :credit_score, :dealership_id, :contact_preference_type_id, :street, :city, :state, :zipcode]

    if params[:action] == 'update'
      devise_parameter_sanitizer.permit(:account_update) { 
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.permit(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    end
  end
end
