class Users::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    edit_user_registration_path
  end

  private 
    def update_resource(resource, params)
      # Require current password if user is trying to change password.
      return super if params["password"]&.present?

      # Allows user to update registration information without password.
      resource.update_without_password(params.except("current_password"))
      # redirect_to new_post_path - need to fix
    end

    def registration_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :image, :phone_number, :credit_score, :dealership_id, :contact_preference_type_id)
    end
end
