class Users::RegistrationsController < Devise::RegistrationsController
  def edit
    routing_error  # Invalidate a "/users/edit"
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      # respond_with resource, location: after_update_path_for(resource)
      render "user_settings/update"
    else
      clean_up_passwords resource
      # respond_with resource
      render json: format_error_message(resource), status: :unprocessable_entity
    end
  end
 
end
