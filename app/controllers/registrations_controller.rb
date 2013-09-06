class RegistrationsController < Devise::RegistrationsController
  include LoginHelper

  def create
    build_resource

    if resource.save
      return render json: {success: true}
    else
      clean_up_passwords resource
      return render json: {success: false, errors: resource.errors}
    end
  end
end
