class WantAdsController < ApplicationController
  def index
    @want_ads = WantAd.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @want_ads }
    end
  end

  def show
    @want_ad = WantAd.find(params[:id])

    if current_user.present?
      @q_owner = current_user.id == @want_ad.user_id

      if @q_owner
        @applications = @want_ad.applications
      end

      unless @q_owner
        @application = @want_ad.applications.where(applicant_id: current_user.id).last
        @q_applied = @application.present?
      end
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
end
