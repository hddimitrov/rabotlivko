class ConfirmationsController < Devise::ConfirmationsController

  # POST /confirmation
  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)

    if successfully_sent?(resource)
      render json: {success: true}
    else
      render json: {success: false, errors: resource.errors}
    end
  end

end
