class AdvertsController < ApplicationController
  # GET /adverts
  # GET /adverts.json
  def index
    @adverts = Advert.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @adverts }
    end
  end

  # GET /adverts/1
  # GET /adverts/1.json
  def show
    @advert = Advert.find(params[:id])
    @q_owner = current_user.present? and current_user.id == @advert.user_id

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @advert }
    end
  end

  # GET /adverts/new
  # GET /adverts/new.json
  def new
    @advert = Advert.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @advert }
    end
  end

  # GET /adverts/1/edit
  def edit
    @advert = Advert.find(params[:id])
  end

  # POST /adverts
  # POST /adverts.json
  def create
    @advert = Advert.new(params[:advert])
    @advert.user_id = current_user.id

    respond_to do |format|
      if @advert.save
        format.html { redirect_to @advert, notice: 'Advert was successfully created.' }
        format.json { render json: @advert, status: :created, location: @advert }
      else
        format.html { render action: "new" }
        format.json { render json: @advert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /adverts/1
  # PUT /adverts/1.json
  def update
    @advert = Advert.find(params[:id])

    respond_to do |format|
      if @advert.update_attributes(params[:advert])
        format.html { redirect_to @advert, notice: 'Advert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @advert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adverts/1
  # DELETE /adverts/1.json
  def destroy
    @advert = Advert.find(params[:id])
    @advert.destroy

    respond_to do |format|
      format.html { redirect_to adverts_url }
      format.json { head :no_content }
    end
  end

  def filter
    if params[:category_id].present?
      @adverts = Advert.joins(:user)
                      .joins("LEFT OUTER JOIN addresses a ON a.addressable_id = adverts.id and a.addressable_type = 'Advert'")
                      .joins("LEFT OUTER JOIN cities c on c.id = a.city_id")
                      .where(category_id: params[:category_id])
                      .select("c.name AS city_name, users.name AS user_name, adverts.*")
      render json: @adverts.to_json and return
    else
      render json: []
    end
  end
end
