class JobsController < ApplicationController
  before_filter :authenticate_user!

  def apply_want_ad
    want_ad = WantAd.find_by_id(params[:id])

    if want_ad.present?
      want_ad.applications.create({applicant_id: current_user.id, applicant_status: 'applied'})
    end

    render nothing: true
  end

  def resign_want_ad
    want_ad = WantAd.find_by_id(params[:id])

    if want_ad.present?
      my_app = want_ad.applications.where(applicant_id: current_user.id).last
      my_app.update_attribute(:applicant_status, 'resigned')
    end

    render nothing: true
  end
end
