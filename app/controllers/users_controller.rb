class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])

    adverts = @user.adverts
    want_ads = @user.want_ads

    @adverts_active     = Advert.active
    @advert_drafts      = Advert.drafts
    @fav_adverts        = current_user.favorite_adverts

    @wanted_ads_active  = WantAd.active
    @wanted_ads_archive = WantAd.archived
    @wanted_ad_drafts   = WantAd.drafts
    @fav_want_ads       = current_user.favorite_wantads
  end

  def profile_master
    redirect_to user_path(current_user.id)
  end

  def contractors_index
    @contractors = User.where(q_contractor: true)
  end

  def become_contractor
    current_user.q_contractor = true
    current_user.save

    address = Address.find_or_create_by_addressable_type_and_addressable_id('User', current_user.id)
    address.state_id = params[:state_id]
    address.city_id = params[:city_id]
    address.save

    if params[:contractor_categories].present?
      params[:contractor_categories].each do |cat|
        ContractorCategory.find_or_create_by_contractor_id_and_category_id(current_user.id, cat)
      end
    end

    redirect_to contractors_path
  end
end
