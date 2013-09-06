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
    page = params[:page] || 1

    adverts  = Advert.active.joins(:user)
                      .joins("LEFT OUTER JOIN addresses a ON a.addressable_id = adverts.id and a.addressable_type = 'Advert'")
                      .joins("LEFT OUTER JOIN cities ON cities.id = a.city_id")
                      .select('users.name as user_name, cities.name as city_name, adverts.*')

    adverts = adverts.where(category_id: params[:category_id]) if params[:category_id].present?
    adverts = adverts.where("cities.id = #{params[:city_id]}") if params[:city_id].present?
    adverts = adverts.where("price >= #{params[:min_price]}") if params[:min_price].present?
    adverts = adverts.where("price <= #{params[:max_price]}") if params[:max_price].present?
    adverts = adverts.where("title ILIKE '%#{params[:search]}%' OR description ILIKE '%#{params[:search]}%'") if params[:search].present?

    adverts = adverts.order("#{params[:sort_by]}") if params[:sort_by].present?
    adverts = adverts.page(page)

    adverts.map do |advert|
      {
        id: advert.id,
        title: advert.title,
        description: advert.description,
        deadline: advert.deadline,
        owner_name: advert.user_name,
        city_name: advert.city_name,
        price: advert.price
      }
    end

    render json: {
      adverts: adverts,
      number_pages: adverts.total_pages,
      current_page: page
    }
  end
end
