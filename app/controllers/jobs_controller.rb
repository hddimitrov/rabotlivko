class JobsController < ApplicationController
  before_filter :authenticate_user!

  def set_applicant_status_want_ad
    want_ad = WantAd.find_by_id(params[:id])
    if want_ad.present?
      my_app = want_ad.applications.find_or_initialize_by_applicant_id(current_user.id)
      my_app.applicant_status = params[:status]
      my_app.save
    end
    render nothing: true
  end

  def set_owner_status_want_ad
    want_ad = WantAd.find_by_id(params[:id])
    if want_ad.present?
      my_app = want_ad.applications.find_or_initialize_by_applicant_id(current_user.id)
      my_app.applicant_status = params[:status]
      my_app.save
    end
    render nothing: true
  end

  def get_applications_want_ad
    want_ad = WantAd.find_by_id(params[:id])
    if want_ad.present? && want_ad.user_id == current_user.id
      applications = []
      want_ad.applications.each do |app|
        applications << {app_id: app.id,
          applicant_name: app.applicant.name,
          owner_status: app.owner_status,
          applicant_status: app.applicant_status}
      end
      render json: applications and return
    end
    render json: []
  end
end
