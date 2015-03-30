class UserRegistrationsController < Devise::RegistrationsController
  include WorkersHelper

  helper_method :display_skills
  before_filter :authenticate_user!, only: [:edit, :update]
  after_action :verify_authorized, only: [:edit, :update]

  def edit
    authorize current_user.rolable
  end
  
  def create
    build_resource(sign_up_params)

    child_class = params[:user][:rolable_type].camelize.constantize

    # split skills into array before create
    if child_class.to_s.underscore == 'worker'
      params[child_class.to_s.underscore][:skills] = parse_skills(params[child_class.to_s.underscore][:skills])
    end

    resource.rolable = child_class.new(params.require(child_class.to_s.underscore).permit!)

    valid = resource.valid?
    valid = resource.rolable.valid? && valid

    if valid
      resource_saved = resource.save
      yield resource if block_given?
      if resource_saved
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        @validatable = devise_mapping.validatable?
        if @validatable
          @minimum_password_length = resource_class.password_length.min
        end
        respond_with resource
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end

  def update
    authorize current_user.rolable

    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    child_class = params[:user][:rolable_type].camelize.constantize

    # split skills into array before update
    if child_class.to_s.underscore == 'worker'
      params[child_class.to_s.underscore][:skills] = parse_skills(params[child_class.to_s.underscore][:skills])
    end

    rolable_updated = resource.rolable.update_attributes(params.require(child_class.to_s.underscore).permit!)

    resource_updated = update_resource(resource, account_update_params) && rolable_updated
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
end