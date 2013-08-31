class WantAdsController < ApplicationController
  # GET /want_ads
  # GET /want_ads.json
  def index
    @cities = City.order(:name)
    @want_ads = WantAd.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @want_ads }
    end
  end

  # GET /want_ads/1
  # GET /want_ads/1.json
  def show
    @want_ad = WantAd.find(params[:id])

    if current_user.present?
      @q_owner = current_user.present? && current_user.id == @want_ad.user_id

      if @q_owner
        @applications = @want_ad.applications
      else
        @application = @want_ad.applications.where(applicant_id: current_user.id).last
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @want_ad }
    end
  end

  # GET /want_ads/new
  # GET /want_ads/new.json
  def new
    @want_ad = WantAd.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @want_ad }
    end
  end

  # GET /want_ads/1/edit
  def edit
    @want_ad = WantAd.find(params[:id])
  end

  # POST /want_ads
  # POST /want_ads.json
  def create
    @want_ad = WantAd.new(params[:want_ad])
    @want_ad.user_id = current_user.id

    respond_to do |format|
      if @want_ad.save
        format.html { redirect_to @want_ad, notice: 'Want ad was successfully created.' }
        format.json { render json: @want_ad, status: :created, location: @want_ad }
      else
        format.html { render action: "new" }
        format.json { render json: @want_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /want_ads/1
  # PUT /want_ads/1.json
  def update
    @want_ad = WantAd.find(params[:id])

    respond_to do |format|
      if @want_ad.update_attributes(params[:want_ad])
        format.html { redirect_to @want_ad, notice: 'Want ad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @want_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /want_ads/1
  # DELETE /want_ads/1.json
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
    want_ads  = WantAd.joins(:user)
                      .joins("LEFT OUTER JOIN addresses a ON a.addressable_id = want_ads.id and a.addressable_type = 'WantAd'")
                      .joins("LEFT OUTER JOIN cities ON cities.id = a.city_id")
                      .select('users.name as user_name, cities.name as city_name, want_ads.*')

    want_ads = want_ads.where(category_id: params[:category_id]) if params[:category_id].present?
    want_ads = want_ads.where("cities.id = #{params[:city_id]}") if params[:city_id].present?
    want_ads = want_ads.where("price >= #{params[:min_price]}") if params[:min_price].present?
    want_ads = want_ads.where("price <= #{params[:max_price]}") if params[:max_price].present?
    want_ads = want_ads.where("deadline <= '#{params[:date]}'") if params[:date].present?

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

    render json: want_ads
  end
end
