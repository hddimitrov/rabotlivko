class WantAdsController < ApplicationController
  def index
    @cities = City.order(:name)
    @want_ads = WantAd.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @want_ads }
    end
  end

  def show
    @want_ad = WantAd.find(params[:id])
    # friendly_id
    if request.path != want_ad_path(@want_ad)
      return redirect_to @want_ad, status: :moved_permanently
    end

    @categories = Category.all.map {|x| {value: x.id, text: x.title}}
    @applications = []

    if current_user.present?
      @q_owner = current_user.id == @want_ad.user_id
      @want_ad_user = @want_ad.user

      if @q_owner
        @want_ad.applications.each do |app|
          @applications << {app_id: app.id,
            applicant_name: app.applicant.name,
            owner_status: app.owner_status,
            applicant_status: app.applicant_status}
        end
      end

      unless @q_owner
        @application = @want_ad.applications.where(applicant_id: current_user.id).last
      end
    end
  end

  def new
    @want_ad = WantAd.new
  end

  def create
    @want_ad = WantAd.new
    @want_ad.user_id = current_user.id
    @want_ad.title = params[:want_ad][:title]
    @want_ad.description = params[:want_ad][:description]
    @want_ad.category_id = params[:want_ad][:category_id]
    if params[:want_ad][:price_negotiable]
      @want_ad.q_price_negotiable = true
    else
      @want_ad.price = params[:want_ad][:price]
    end
    @want_ad.deadline = params[:want_ad][:deadline] if params[:want_ad][:deadline].present?

    @want_ad.build_address(params[:want_ad][:address])

    if @want_ad.save
      redirect_to @want_ad
    end
  end

  def update

    if current_user.present?
      want_ad = WantAd.find_by_id(params[:pk])

      if want_ad.present? && want_ad.user_id == current_user.id
        case params[:name]
          when 'title'
            want_ad.title = params[:value]
          when 'description'
            want_ad.description = params[:value]
          when 'category_id'
            want_ad.category_id = params[:value]
          when 'city_id'
            want_ad.address.city_id = params[:value]
          when 'price'
            want_ad.price = params[:price]
          else
        end

        if want_ad.changed?
          want_ad.save
        end

        if want_ad.address.present? && want_ad.address.changed?
          want_ad.address.save
        end
      end
    end

    render nothing: true
  end

  def destroy
    @want_ad = WantAd.find(params[:id])
    @want_ad.destroy

    respond_to do |format|
      format.html { redirect_to want_ads_url }
      format.json { head :no_content }
    end
  end

  # category_id
  # min_price, max_price
  # deadline

  def filter
    page = params[:page] || 1

    want_ads  = WantAd.active.joins(:user)
                      .joins("LEFT OUTER JOIN addresses a ON a.addressable_id = want_ads.id and a.addressable_type = 'WantAd'")
                      .joins("LEFT OUTER JOIN cities ON cities.id = a.city_id")
                      .select('users.name as user_name, cities.name as city_name, want_ads.*')

    want_ads = want_ads.where(category_id: params[:category_id]) if params[:category_id].present?
    want_ads = want_ads.where("cities.id = #{params[:city_id]}") if params[:city_id].present?
    want_ads = want_ads.where("price >= #{params[:min_price]}") if params[:min_price].present?
    want_ads = want_ads.where("price <= #{params[:max_price]}") if params[:max_price].present?
    want_ads = want_ads.where("deadline <= '#{params[:date]}'") if params[:date].present?
    want_ads = want_ads.where("title ILIKE '%#{params[:search]}%' OR description ILIKE '%#{params[:search]}%'") if params[:search].present?

    want_ads = want_ads.order("#{params[:sort_by]}") if params[:sort_by].present?
    want_ads = want_ads.page(page)

    want_ads.map do |want_ad|
      {
        id: want_ad.id,
        title: want_ad.title,
        description: want_ad.description,
        deadline: want_ad.deadline,
        owner_name: want_ad.user_name,
        city_name: want_ad.city_name,
        price: want_ad.price
      }
    end

    render json: {
      want_ads: want_ads,
      number_pages: want_ads.total_pages,
      current_page: page
    }
  end
end
