class SessionsController < Devise::SessionsController
 include LoginHelper

  def create
    resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#failure")
    sign_in_and(resource_name, resource)
    return render json: {success: true}
  end

  def failure
    return render json: {success: false, errors: ['Login failed.']}
  end
end
